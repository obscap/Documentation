# Main Entry point here: -

## Feed Handler

feed_handler.cpp file is responsible for data ingestion, it also maintain the streamline between components

Feed Handler has a Pimpl Implementation of class;
The following Pimpl contains 

* Arbitrator: - Arbitrator process the feed packates that have recivied. 
* Collector: - It collects the raw packates that receives from udp data.
* SPSC Queues: - The SPSC Ques is multiple producer multiple consumer queues.
* Wal (Write Ahead Logs): - It Might beused in aribator or collector.
    - Aribator and Collector are both threads
    - Aribator runs on aribator func
    - Collector runs on collector func

Both the Func job is to start the threads and assign an isolated core to the cpu

* internal_ring: - A Ring Buffer That is responsible for sharing the data between collector and aribator
* spsc Queues: - It is a queue that is responsible for data that is prepared after Aribator does it Jobs
* sources: - Sources are combination of interface and port // {"eth0", 1254}
It is use ahead in xdp for kernel bypassing
* token_filter: - Unknown
* RawPkt: - Unknown

### Function: -

* start(): - Start Both the aribator and Collector. aribator_func is assigned to the Aribator Thread. collector_func is assigned to the collector func.
* stop(): - Stop both the running threads and call the collector destructor.
* arbitrator_func(): - While running is set to true it will trie to read any data avaliable and then empty it from ring buffer.
    - Do Note that aribator is created before hand in FeedHandler Constructor since there might be case Aribator starts first so it might fill the ring buffer up and data might drop.
* collector_func(): - Collector Func is where a new object of collector is created.