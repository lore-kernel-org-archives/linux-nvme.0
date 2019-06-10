From: keith.busch@gmail.com (Keith Busch)
Date: Mon, 10 Jun 2019 07:55:49 -0600
Subject: [RFC] mismatch between chardev and blkdev node names
In-Reply-To: <20190610124925.GA20319@minwooim-desktop>
References: <20190610124925.GA20319@minwooim-desktop>
Message-ID: <CAOSXXT6BJD8tnus6=vWh6dr9owkVSJdQ_f1icG9Kdq7SpF9Pzg@mail.gmail.com>

On Mon, Jun 10, 2019@6:49 AM Minwoo Im <minwoo.im.dev@gmail.com> wrote:
> Should users with multipath enabled know this situation well and do
> something with perfect understanding this policy because they might be
> administrator for the system?  or should the driver provide the same
> index at least right next to "nvme" for the controller and namespaces?

You can't just use the controller instance for the namespace names
when multipathing: you can't consistently name the namespace that is
accessible through two controllers that way. You have to use an
identifier that is common to all controllers with a shared namespace
access, which is the subsystem instance.

You just need to know this if you're accessing direct namespace
handles, and the controller-namespace relationship is accurately
represented in sysfs for those wanting to view it.
