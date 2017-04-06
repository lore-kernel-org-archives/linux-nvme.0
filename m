From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 6 Apr 2017 11:30:02 +0300
Subject: [PATCH rfc 6/6] nvme-rdma: use intelligent affinity based queue
 mappings
In-Reply-To: <20170404063444.GF8978@lst.de>
References: <1491140492-25703-1-git-send-email-sagi@grimberg.me>
 <1491140492-25703-7-git-send-email-sagi@grimberg.me>
 <20170404063444.GF8978@lst.de>
Message-ID: <d896e706-ae78-6be1-dd21-fa73150537b4@grimberg.me>


>> Use the geneic block layer affinity mapping helper. Also,
>
>           generic
>
>>  	nr_io_queues = min(opts->nr_io_queues, num_online_cpus());
>> +	nr_io_queues = min_t(unsigned int, nr_io_queues,
>> +				ibdev->num_comp_vectors);
>> +
>
> Add a comment here?

Will do
