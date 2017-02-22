From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 22 Feb 2017 21:55:34 +0200
Subject: [PATCH] nvme-rdma: Support 2 inline data SGEs for write commands.
In-Reply-To: <VI1PR0502MB3008D4BD11A7F360840347A4D1500@VI1PR0502MB3008.eurprd05.prod.outlook.com>
References: <VI1PR0502MB3008FAE182CFAFA906ECF62DD1500@VI1PR0502MB3008.eurprd05.prod.outlook.com>
 <b91079ca-0d63-8dae-6a3f-281fc0deb636@grimberg.me>
 <VI1PR0502MB3008D4BD11A7F360840347A4D1500@VI1PR0502MB3008.eurprd05.prod.outlook.com>
Message-ID: <1b133bcf-9b4e-9817-dbff-9b69dbcb01dc@grimberg.me>


>>> Hi Christoph, Sagi,
>>
>>> Does this host side patch look fine? Its unrelated to target side
>> implementation.
>>
>> I'm still wandering if we want it dynamic according to the target ioccsz (say 1
>> per PAGE_SIZE?)
>
> I don't think we are consuming any more resources by increasing to 2SGEs because it's still aligns to hardware's minimum WQE size of 64B or 128B size.
> Can we add that additional complexity in incremental manner unless 2 SGEs are less optimal compared to 1?

I'm referring to struct nvme_rdma_request
