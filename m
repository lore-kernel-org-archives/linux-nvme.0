From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 5 Oct 2018 00:34:27 -0700
Subject: Kernel v4.19-rc4 KASAN complaint
In-Reply-To: <20180920173625.GB31127@localhost.localdomain>
References: <6892a170-0dcf-9498-19c2-50e1ae89f4ef@acm.org>
 <20180920170145.GA31127@localhost.localdomain>
 <1537464689.224533.10.camel@acm.org>
 <20180920173625.GB31127@localhost.localdomain>
Message-ID: <20181005073427.GA7075@infradead.org>

On Thu, Sep 20, 2018@11:36:25AM -0600, Keith Busch wrote:
> > >  	mutex_lock(&ns->ctrl->subsys->lock);
> > > -	nvme_mpath_clear_current_path(ns);
> > >  	list_del_rcu(&ns->siblings);
> > > +	nvme_mpath_clear_current_path(ns);
> > >  	mutex_unlock(&ns->ctrl->subsys->lock);
> > >  
> > >  	down_write(&ns->ctrl->namespaces_rwsem);
> > 
> > That patch makes the KASAN complaint disappear on my test setup.
> 
> Nice, thanks for confirming. I'll send a proper patch, but also wonder
> why the error doesn't show up in 4.18.

Independent of fixing the issue Bart reported this looks like a good
fix, can you send a proper patch for it?
