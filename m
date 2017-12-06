From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 6 Dec 2017 14:54:13 +0200
Subject: [PATCH] nvmet: Limit num of queues to num of cpus on traget
In-Reply-To: <20171206113624.989-1-nitzanc@mellanox.com>
References: <20171206113624.989-1-nitzanc@mellanox.com>
Message-ID: <a0c4d4d4-5b63-4a88-20d8-6b774802e6fb@grimberg.me>


> Sagi/Christoph,
> In case the NVMEoF host asks num_io_queues << num_target_cpus there is
> a waste of memory allocated in the target side for the sq's/cq's that
> we never use. We might want to check the number of needed queues in
> "set_features" cmd and allocate the minimum(wanted, target_capable).
> This will block the option of creating more queues in a later stage
> of the host lifecycle, but saves resources.
> 
> thoughts ?

This is not the way to go at all. If you really care about saving a few
Kbytes of nvmet sq/cq and see that its a real problem, you need to
allocate them on demand instead of posing this limit to the host.
