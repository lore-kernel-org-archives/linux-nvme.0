From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 22 Feb 2017 22:07:00 +0200
Subject: [PATCH] nvme-rdma: Support 2 inline data SGEs for write commands.
In-Reply-To: <VI1PR0502MB3008674F9EA0F9D891CE06F2D1500@VI1PR0502MB3008.eurprd05.prod.outlook.com>
References: <VI1PR0502MB3008FAE182CFAFA906ECF62DD1500@VI1PR0502MB3008.eurprd05.prod.outlook.com>
 <b91079ca-0d63-8dae-6a3f-281fc0deb636@grimberg.me>
 <VI1PR0502MB3008D4BD11A7F360840347A4D1500@VI1PR0502MB3008.eurprd05.prod.outlook.com>
 <1b133bcf-9b4e-9817-dbff-9b69dbcb01dc@grimberg.me>
 <VI1PR0502MB3008674F9EA0F9D891CE06F2D1500@VI1PR0502MB3008.eurprd05.prod.outlook.com>
Message-ID: <c9679af1-cece-07d0-1ba9-af475a4f1070@grimberg.me>


>> I'm referring to struct nvme_rdma_request
> Yes, I got that now.
> That needs to have dynamic allocation for sge array if we want to do based on ioccsz.
> Unless we do 4 or 8 or larger SGEs, extra 8 byte pointer to store link to more than one SGE might not be worth enough just for writes.

Which is what Christoph asked, why not 4 or 8?
