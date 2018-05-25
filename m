From: snitzer@redhat.com (Mike Snitzer)
Date: Fri, 25 May 2018 09:47:54 -0400
Subject: [PATCH 1/3] nvme: provide a way to disable nvme mpath per
 subsystem
In-Reply-To: <20180525125322.15398-2-jthumshirn@suse.de>
References: <20180525125322.15398-1-jthumshirn@suse.de>
 <20180525125322.15398-2-jthumshirn@suse.de>
Message-ID: <20180525134753.GA9591@redhat.com>

On Fri, May 25 2018 at  8:53am -0400,
Johannes Thumshirn <jthumshirn@suse.de> wrote:

> Provide a way to disable NVMe native multipathing on a per-subsystem
> basis to enable a user to use dm-mpath and nvme native multipathing on
> the same host for different nvme devices.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>

Acked-by: Mike Snitzer <snitzer at redhat.com>
