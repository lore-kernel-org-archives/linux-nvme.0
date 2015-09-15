From: sujithpshankar@gmail.com (Sujith Pandel)
Date: Tue, 15 Sep 2015 16:26:09 -0400
Subject: [PATCH v2] NVMe:Expose model attribute in sysfs
In-Reply-To: <20150909062713.GA14279@localhost.localdomain>
References: <20150909062713.GA14279@localhost.localdomain>
Message-ID: <20150915202603.GA3619@localhost.localdomain>

On Wed, Sep 09, 2015@01:27:36AM -0500, Sujith Pandel wrote:
> nvme driver does not show the model attribute of disk in sysfs.
> nvme_dev already has this attribute populated during nvme_dev_add().
> Group model and other the device attributes as an attribute group
> and create sysfs files for the group using sysfs_create_group().

Any updates on this? Can this be considered for inclusion?

Thanks!
Sujith
