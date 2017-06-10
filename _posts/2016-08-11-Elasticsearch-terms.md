---
title: Elasticsearch basic terminologies
date: 2016-08-11 00:00:00 Z
layout: post
tags:
- misc.
---

Elasticsearch is a distributed search engine. You dump data to some elasticsearch-index, and then you can make http queries to search the data.

> Under the hood, it uses Lucene(search engine library). It creates multiple Lucene indexes( or shard in elasticsearch) for data and distributes them across the nodes. To resolves the search-query sent to elasticsearch, it queries all lucene indexes and combines results and gives back the result.


* **Cluster** – An Elasticsearch cluster consists of *one or more nodes*, working together to search and store data and is identifiable by its cluster name.

* **Node** – A single Elasticsearch instance. In most environments, each node runs on a separate box or virtual machine.
It can be one of 4 types.

    * *Master* -- Master only node meaning it can work towards cluster related tasks such as shard allocation in the event of new machine availability and/or machine unavailability (instance failure).
    * *Data* -- This node can only store data. This is a worker node which just work on indexing data and returning search results.
    * *Client(Not master neither data)* -- This node never stores any data and never becomes a master, it works as a load balancer. It accepts incoming query requests and routes to a data node.  Fetches data from nodes, aggregates results.
    * *Master and Data* -- This is the default setting. A node stores data and is capable of becoming a master node.

    It is controlled by 2 values in config value

        node.data: true
        node.master: true

* **Index**

    * An index is a collection of documents that have somewhat similar characteristics.
    * Analogy can be what **index is to elasticsearch is what database to RDBMS.**
    * Within index we store multiple kinds of data.
    * Data coming to specific index is stored in elasticsearch using a mapping that elasticsearch does dyanmically of you, you can(should) do it manually too.
    * An index is a logical namespace which points to primary and replica shards.




> * Within index we can have documents of **multiple type**.
> * **Type** you can think as a table in RDBMS.
> * Type has a name and a mapping and each document belongs to some index and is of certain type.
> * A document is a basic unit of information, json data you see is a document.


* **Shard**
    * Shard is basically lucene index(not elasticsearch index).
    * Shards are shared across the node to provide distributed search(they're are part of a index).
    * Shards are of two types; *Primay*, *Replica*.
    * Primary's are the one that you can specify only once while creating the index, and replica's are copy of primary shards, which can be altered after index creation.
    * Every time you index a document, elasticsearch will decide which primary shard is supposed to hold that document and will index it there. **Primary shards are not copy of the data, they are the data!**
    * Every elasticsearch index is composed of at least one primary shard, since that's where the data is stored.
    * **Replica**
    	* Replica is shard which is exact copy of primary shard i.e. it'll contain the same data. Replicas are used to increase search performance and for fail-over.
    	* Replica is never allocated on the same node where their primary is.
    * You don't play with shard directly other than specifiying config values for **primary shard** and **replicas**







**References**

* [http://www.xmsxmx.com/elasticsearch-cluster-configuration-best-practices/](http://www.xmsxmx.com/elasticsearch-cluster-configuration-best-practices/)
*
* [https://stackoverflow.com/questions/15694724/shards-and-replicas-in-elasticsearch](https://stackoverflow.com/questions/15694724/shards-and-replicas-in-elasticsearch)
* [https://stackoverflow.com/questions/15025876/what-is-an-index-in-elasticsearch](https://stackoverflow.com/questions/15025876/what-is-an-index-in-elasticsearch)
* [http://cpratt.co/how-many-shards-should-elasticsearch-indexes-have/](https://http://cpratt.co/how-many-shards-should-elasticsearch-indexes-have/)



