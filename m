From: snitzer@redhat.com (Mike Snitzer)
Date: Sat, 2 Mar 2019 00:29:50 -0500
Subject: nvme-fc: fix numa_node when dev is null
In-Reply-To: <20190301211933.26297-1-jsmart2021@gmail.com>
References: <20190301211933.26297-1-jsmart2021@gmail.com>
Message-ID: <20190302052950.GA32442@redhat.com>

On Fri, Mar 01 2019 at  4:19pm -0500,
James Smart <jsmart2021@gmail.com> wrote:

> A recent change added a numa_node field to the nvme controller
> and has the transport assign the node using dev_to_node().
> However, fcloop registers with a NULL device struct, so the
> dev_to_node() call oops.
> 
> Revise the assignment to assign no node when device struct is null.
> 
> Fixes: 	103e515efa89b  ("nvme: add a numa_node field to struct nvme_ctrl")
> Reported-by: Mike Snitzer <snitzer at redhat.com>
> Signed-off-by: James Smart <jsmart2021 at gmail.com>

Reviewed-by: Mike Snitzer <snitzer at redhat.com>

Thanks James.
