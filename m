From: swise@opengridcomputing.com (Steve Wise)
Date: Wed, 5 Apr 2017 10:43:38 -0500
Subject: [RFC 4/8] p2pmem: Add debugfs "stats" file
In-Reply-To: <95928b70-0148-7297-8f5e-5031d996bb98@grimberg.me>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
 <1490911959-5146-5-git-send-email-logang@deltatee.com>
 <95928b70-0148-7297-8f5e-5031d996bb98@grimberg.me>
Message-ID: <003201d2ae23$6527ef10$2f77cd30$@opengridcomputing.com>

> 
> > +	p2pmem_debugfs_root = debugfs_create_dir("p2pmem", NULL);
> > +	if (!p2pmem_debugfs_root)
> > +		pr_info("could not create debugfs entry, continuing\n");
> > +
> 
> Why continue? I think it'd be better to just fail it.
> 

Because not having debugfs support isn't fatal to using p2pmem.  So I
believe it is better to continue.  But this is trivial, IMO, so either was
is ok with me.

> Besides, this can be safely squashed into patch 1.

Yes.
