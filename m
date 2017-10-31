From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 31 Oct 2017 11:38:25 +0200
Subject: [PATCH 0/3] Fix request completion holes
In-Reply-To: <1509440122-1190-1-git-send-email-sagi@grimberg.me>
References: <1509440122-1190-1-git-send-email-sagi@grimberg.me>
Message-ID: <8abcde91-9150-2982-3900-078619bcdac0@mellanox.com>



On 10/31/2017 10:55 AM, Sagi Grimberg wrote:
> We have two holes in nvme-rdma when completing request.
> 

Thanks Sagi.
We'll run these patches in our lab + our patches for the performance 
improvments that we sent few days ago and update the results.

I guess I'll need to run it with my cq moderation patches to get less 
penalty in performance.
