From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 22 Feb 2017 21:38:40 +0200
Subject: [PATCH] nvme-rdma: Support 2 inline data SGEs for write commands.
In-Reply-To: <VI1PR0502MB3008FAE182CFAFA906ECF62DD1500@VI1PR0502MB3008.eurprd05.prod.outlook.com>
References: <VI1PR0502MB3008FAE182CFAFA906ECF62DD1500@VI1PR0502MB3008.eurprd05.prod.outlook.com>
Message-ID: <b91079ca-0d63-8dae-6a3f-281fc0deb636@grimberg.me>


> Hi Christoph, Sagi,

> Does this host side patch look fine? Its unrelated to target side implementation.

I'm still wandering if we want it dynamic according to the target
ioccsz (say 1 per PAGE_SIZE?)
