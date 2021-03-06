RSpec.describe PWork::Async do
  describe '#mode' do
    context 'when a value is NOT specified via env variable' do
      before do
        ENV['PWORK_ASYNC_MODE'] = nil
      end
      it 'returns the default value' do
        expect(PWork::Async.mode).to eq 'thread'
      end
    end
    context 'when a value is specified via env variable' do
      context 'when async mode is set to fork' do
        before do
          ENV['PWORK_ASYNC_MODE'] = 'fork'
        end
        it 'returns the env var value' do
          expect(PWork::Async.mode).to eq 'fork'
        end
      end
      context 'when async mode is set to thread' do
        before do
          ENV['PWORK_ASYNC_MODE'] = 'thread'
        end
        it 'returns the env var value' do
          expect(PWork::Async.mode).to eq 'thread'
        end
      end
    end
  end
  describe '#reset' do
    it 'clears the task list' do
      PWork::Async.tasks << :foo
      expect(PWork::Async.tasks.length).to eq 1
      PWork::Async.reset
      expect(PWork::Async.tasks.length).to eq 0
    end
  end
  describe '#tasks' do
    it 'returns task array' do
      expect(PWork::Async.tasks).to be_a(Array)
    end
  end
  describe '#add_task' do
    let(:task) do
      PWork::Async::Task.new
    end
    let(:block) do
      Proc.new do
        # do nothing
      end
    end
    context 'when wait: false is NOT specified' do
      it 'adds the task to the task list' do
        expect(PWork::Async.tasks.length).to eq 0
        PWork::Async.add_task({}, &block)
        expect(PWork::Async.tasks.length).to eq 1
      end
      after do
        PWork::Async.reset
      end
    end
    context 'when wait: false is specified' do
      it 'adds the task to the task list' do
        expect(PWork::Async.tasks.length).to eq 0
        PWork::Async.add_task({wait: false}, &block)
        expect(PWork::Async.tasks.length).to eq 0
      end
      after do
        PWork::Async.reset
      end
    end
  end
end
