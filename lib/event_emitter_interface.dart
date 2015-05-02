abstract class EventEmitterInterface {
    void addListener(event, listener);

    void on(event, listener);

    void once(event, listener);

    void removeListener(event, listener);

    void removeAllListeners([event]);

    void setMaxListeners(int n);

    void listeners(event);

    void emit(event, [data]);

    int listenerCount(event);
}
