From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 6 Jul 2017 10:51:36 +0300
Subject: [PATCH v2 1/3] RDMA/core: make ib_device.add method optional
In-Reply-To: <1498983652-18250-2-git-send-email-sagi@grimberg.me>
References: <1498983652-18250-1-git-send-email-sagi@grimberg.me>
 <1498983652-18250-2-git-send-email-sagi@grimberg.me>
Message-ID: <14303999-2479-653c-719f-ac5a5b03fb33@grimberg.me>

> ib_clients can indeed fill .add to NULL, but then they will not see
> any device removal notifications. The reason is that that
> ib_register_client and ib_register_device checked existence of .add
> before adding the creating a corresponding client_data and adding
> it to the list. Simple condition reverse fixes the issue.
> 
> Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

Any RDMA folks?
