From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 22 Aug 2017 12:36:49 +0300
Subject: [PATCH 2/3] nvme: introduce max_segments controller attribute
In-Reply-To: <20170822063215.GA6627@lst.de>
References: <1502878860-11750-1-git-send-email-maxg@mellanox.com>
 <1502878860-11750-2-git-send-email-maxg@mellanox.com>
 <390a1e0d-8b83-576f-1e9a-c9136b7daf39@grimberg.me>
 <ea59ff5e-5bcc-9dfc-a248-ef02f977dafc@mellanox.com>
 <bd77f99f-67c9-b648-1b93-43d3a6feb414@grimberg.me>
 <20170817074034.GC24372@lst.de>
 <39824829-4a0c-6418-2de7-719461fb3662@grimberg.me>
 <20170822063215.GA6627@lst.de>
Message-ID: <64ff7c30-cfb7-0e66-6882-59349faf8fc2@mellanox.com>

> So for now to be safe it might be a good idea to always use a 4k
> MR page size..
>

So should I send a fix only for the MR page size (4k) for now ?
Or should we add the infrastructure for virt_boundary and max_segments 
per ctrl too ?
