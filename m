From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 26 Jun 2018 12:10:28 +0300
Subject: [PATCH V2] nvmet: use shared workqueue for file-ns
In-Reply-To: <BYAPR04MB45022CF0740F2484E168B0B086490@BYAPR04MB4502.namprd04.prod.outlook.com>
References: <20180623023427.22532-1-chaitanya.kulkarni@wdc.com>
 <5d85fd98-fffd-e326-8aee-7976d1e8921a@grimberg.me>
 <BYAPR04MB450206FFEE99E01912AF260E864B0@BYAPR04MB4502.namprd04.prod.outlook.com>
 <BYAPR04MB45022CF0740F2484E168B0B086490@BYAPR04MB4502.namprd04.prod.outlook.com>
Message-ID: <97d966a9-dae7-9779-1692-4bf9b87b2a1d@grimberg.me>


> Sagi, can you please let me know if you still want me to use the
> system hipri workqueue and send a new version?

I'm fine with a dedicated wq. but still lets rename it.
