From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Mon, 10 Jun 2019 23:06:50 +0900
Subject: [RFC] mismatch between chardev and blkdev node names
In-Reply-To: <CAOSXXT6BJD8tnus6=vWh6dr9owkVSJdQ_f1icG9Kdq7SpF9Pzg@mail.gmail.com>
References: <20190610124925.GA20319@minwooim-desktop>
 <CAOSXXT6BJD8tnus6=vWh6dr9owkVSJdQ_f1icG9Kdq7SpF9Pzg@mail.gmail.com>
Message-ID: <20190610140650.GA25273@minwooim-desktop>

On 19-06-10 07:55:49, Keith Busch wrote:
> On Mon, Jun 10, 2019@6:49 AM Minwoo Im <minwoo.im.dev@gmail.com> wrote:
> > Should users with multipath enabled know this situation well and do
> > something with perfect understanding this policy because they might be
> > administrator for the system?  or should the driver provide the same
> > index at least right next to "nvme" for the controller and namespaces?
> 
> You can't just use the controller instance for the namespace names
> when multipathing: you can't consistently name the namespace that is
> accessible through two controllers that way. You have to use an
> identifier that is common to all controllers with a shared namespace
> access, which is the subsystem instance.

Yeah, I can see things in multipath code just like what you mentioned.

> 
> You just need to know this if you're accessing direct namespace
> handles, and the controller-namespace relationship is accurately
> represented in sysfs for those wanting to view it.

Then the user should exactly know the relationship bettwen the
controller and namespaces via the sysfs structures.

Thanks, Keith.
