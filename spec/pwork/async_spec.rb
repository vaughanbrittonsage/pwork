RSpec.describe PWork::Async do
  describe '#async_wait_sleep_iteration' do
    context 'when a value is NOT specified via env variable' do
      before do
        ENV['PWORK_ASYNC_WAIT_SLEEP_ITERATION'] = nil
      end
      it 'returns the default value' do
        expect(PWork::Async.async_wait_sleep_iteration).to eq 0.02
      end
    end
    context 'when a value is specified via env variable' do
      before do
        ENV['PWORK_ASYNC_WAIT_SLEEP_ITERATION'] = '0.1'
      end
      it 'returns the env var value' do
        expect(PWork::Async.async_wait_sleep_iteration).to eq 0.1
      end
    end
  end
  describe '#mode' do
    context 'when a value is NOT specified via env variable' do
      before do
        ENV['PWORK_ASYNC_MODE'] = nil
      end
      it 'returns the default value' do
        expect(PWork::Async.mode).to eq :thread
      end
    end
    context 'when a value is specified via env variable' do
      context 'when async mode is set to fork' do
        before do
          ENV['PWORK_ASYNC_MODE'] = 'fork'
        end
        it 'returns the env var value' do
          expect(PWork::Async.mode).to eq :fork
        end
      end
      context 'when async mode is set to thread' do
        before do
          ENV['PWORK_ASYNC_MODE'] = 'thread'
        end
        it 'returns the env var value' do
          expect(PWork::Async.mode).to eq :thread
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
end
