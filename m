From: keith.busch@intel.com (Keith Busch)
Date: Mon, 9 Nov 2015 15:43:49 +0000
Subject: [PATCH v2] NVMe:Expose model attribute in sysfs
In-Reply-To: <20150915202603.GA3619@localhost.localdomain>
References: <20150909062713.GA14279@localhost.localdomain>
 <20150915202603.GA3619@localhost.localdomain>
Message-ID: <20151109154349.GA4735@localhost.localdomain>

On Tue, Sep 15, 2015@04:26:09PM -0400, Sujith Pandel wrote:
> On Wed, Sep 09, 2015@01:27:36AM -0500, Sujith Pandel wrote:
> > nvme driver does not show the model attribute of disk in sysfs.
> > nvme_dev already has this attribute populated during nvme_dev_add().
> > Group model and other the device attributes as an attribute group
> > and create sysfs files for the group using sysfs_create_group().
> 
> Any updates on this? Can this be considered for inclusion?

Yes, I'd like to see this included. It will make it easier to add new
attributes to help the systemd developers[1] identify nvme controllers
and their namespaces.

 [1]  https://github.com/systemd/systemd/issues/1453
