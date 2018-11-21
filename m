From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 20 Nov 2018 21:43:46 -0800
Subject: [PATCH v2 14/14] nvme-tcp: add NVMe over TCP host driver
In-Reply-To: <CY4PR08MB258265FB085A9C26B6F27D93CFDA0@CY4PR08MB2582.namprd08.prod.outlook.com>
References: <20181120030019.31738-1-sagi@grimberg.me>
 <20181120030019.31738-16-sagi@grimberg.me>
 <CY4PR08MB258265FB085A9C26B6F27D93CFDA0@CY4PR08MB2582.namprd08.prod.outlook.com>
Message-ID: <f947a8e0-9e88-2264-e771-11eabe735807@grimberg.me>


> NVME_TCP_DISC_PORT, 8009, should not be the default for nvme fabric connections when trsvcid is not specified.

Its allowed, the statement simply does not recommend it as a possible
misuse in an environment where iWARP and TCP are deployed on the same
port spaces...

And, it recommends that subsystems don't listen on the 8009 by default,
not anything about a host. Furthermore, usually controllers that are not
passed with a default port are discovery controllers anyways.

> NVME_RDMA_IP_PORT, 4420, should be used, or renamed to something more generic.

Not at all... in fact, this is really not what the spec is intending.
