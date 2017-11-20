From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 20 Nov 2017 11:04:41 +0200
Subject: [PATCH v2 2/3] nvme-rdma: don't complete requests before a send
 work request has completed
In-Reply-To: <20171120084102.GA28456@lst.de>
References: <20171108100616.26605-1-sagi@grimberg.me>
 <20171108100616.26605-3-sagi@grimberg.me> <20171109092110.GB16966@lst.de>
 <0f368bc9-2e9f-4008-316c-46b85661a274@grimberg.me>
 <20171120083130.GC27552@lst.de>
 <384d8a51-aa2f-5954-c9fd-a0c88d7e5364@grimberg.me>
 <20171120084102.GA28456@lst.de>
Message-ID: <83a20189-361a-e203-f80f-d7e0caee9607@grimberg.me>


> Btw, in our brave new world that should probably be a refcnt_t instead
> of an atomic_t, but that's a trivial search and replace.

Yea, will change that.
