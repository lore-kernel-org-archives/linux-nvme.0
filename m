From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 26 Jun 2018 12:55:34 -0500
Subject: [PATCH v6 2/2] nvmet-rdma: support max(16KB,
 PAGE_SIZE) inline data
In-Reply-To: <ee7f57ae-7813-8d39-291d-49e2562b9526@grimberg.me>
References: <cover.1529938266.git.swise@opengridcomputing.com>
 <e822e13637192a88f67d6be8cc01d4ff7720c937.1529938266.git.swise@opengridcomputing.com>
 <ee7f57ae-7813-8d39-291d-49e2562b9526@grimberg.me>
Message-ID: <019801d40d76$e29c67b0$a7d53710$@opengridcomputing.com>



> -----Original Message-----
> From: Linux-nvme <linux-nvme-bounces at lists.infradead.org> On Behalf Of
> Sagi Grimberg
> Sent: Tuesday, June 26, 2018 6:13 AM
> To: Steve Wise <swise at opengridcomputing.com>; axboe at kernel.dk;
> hch at lst.de; keith.busch at intel.com; linux-nvme at lists.infradead.org
> Cc: linux-rdma at vger.kernel.org; maxg at mellanox.com;
> dledford at redhat.com; jgg at mellanox.com; parav at mellanox.com
> Subject: Re: [PATCH v6 2/2] nvmet-rdma: support max(16KB, PAGE_SIZE)
> inline data
> 
> 
> > -	pr_info("enabling port %d (%pISpcs)\n",
> > -		le16_to_cpu(port->disc_addr.portid), (struct sockaddr
> *)&addr);
> > +	pr_info("enabling port %d (%pISpcs) inline_data_size %d\n",
> > +		le16_to_cpu(port->disc_addr.portid), (struct sockaddr
> *)&addr,
> > +		port->inline_data_size);
> 
> We can lose the info here, its should be visible via configfs.
> 
> otherwise looks fine,
> 
> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>

Thanks Sagi.  

Hey Christoph, I think this is ready to merge.  Feel free to remove the
pr_info() if you agree.  Or I can repost one more time.

Steve.
