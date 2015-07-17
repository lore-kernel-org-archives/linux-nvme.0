From: jonathan.derrick@intel.com (Jon Derrick)
Date: Fri, 17 Jul 2015 09:46:32 -0600
Subject: [PATCHv4 2/2] NVMe: Use CMB for the IO SQes if available
In-Reply-To: <20150717075123.GB31679@infradead.org>
References: <1437087088-1628-1-git-send-email-jonathan.derrick@intel.com>
 <1437087088-1628-3-git-send-email-jonathan.derrick@intel.com>
 <20150717075123.GB31679@infradead.org>
Message-ID: <20150717154632.GA3621@localhost.localdomain>

> > +static int use_cmb_sqes = 1;
> > +module_param(use_cmb_sqes, int, 0644);
> > +MODULE_PARM_DESC(use_cmb_sqes, "use controller's memory buffer for I/O SQes");
> 
> This should be a bool.
> 

> > +	}
> > +}
> 
> Can you just return an error on allocation failure here insead of
> checking sq_cmds after the call to the function?

Will do. Thanks!
