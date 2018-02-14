From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 14 Feb 2018 15:40:43 +0200
Subject: [PATCH 1/3] nvme: rename NVME_CTRL_RECONNECTING state to
 NVME_CTRL_CONNECTING
In-Reply-To: <HE1PR0501MB1979A7C5B848771064C30C57B6F60@HE1PR0501MB1979.eurprd05.prod.outlook.com>
References: <1517416286-31109-1-git-send-email-maxg@mellanox.com>
 <1517416286-31109-2-git-send-email-maxg@mellanox.com>
 <d8241724-ef3a-4946-4629-3598413ca836@grimberg.me>
 <c896305c-90d0-e4aa-d861-ea9ad0076161@grimberg.me>
 <7a611bf2-8a70-1b11-0616-f79531a2cc3d@mellanox.com>
 <d6e78772-5345-3a03-b376-5656bfebe606@grimberg.me>
 <HE1PR0501MB1979A7C5B848771064C30C57B6F60@HE1PR0501MB1979.eurprd05.prod.outlook.com>
Message-ID: <44b5f866-3b98-ba25-ff8a-3c0ce9f03c8b@grimberg.me>


> During port toggle with traffic (using dm-multipath) I see some
> warnings during ib_destroy_qp that say there are still mrs_used.
> and therefore also in ib_dealloc_pd that says refcount on pd is not 0.
> 
> I'll debug it tomorrow hopefully and update.

Is this a regression that happened due to your patch set?
