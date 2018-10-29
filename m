From: keith.busch@intel.com (Keith Busch)
Date: Mon, 29 Oct 2018 09:55:07 -0600
Subject: [PATCH 2/2] nvme/multipath: Fix multipath disabled naming
 collisions
In-Reply-To: <DA56163F-C776-4A11-AFF0-2A29B68120A8@raithlin.com>
References: <20180426214956.3377-1-keith.busch@intel.com>
 <20180426214956.3377-3-keith.busch@intel.com>
 <CAD4F464-15CC-44B9-9C72-B5F2BDFC5445@raithlin.com>
 <20181029154229.GA16586@localhost.localdomain>
 <DA56163F-C776-4A11-AFF0-2A29B68120A8@raithlin.com>
Message-ID: <20181029155506.GA16595@localhost.localdomain>

On Mon, Oct 29, 2018@03:48:52PM +0000, Stephen  Bates wrote:
> > > Note how the /nvme/nvme0/ sysfs directory contains the nvme1n1
> > > namespace. Is this expected? I am not that familiar with the multipath
> > > code so I'm not sure if this is a bug or not but it sure is confusing.
> > > Disabling CONFIG_NVME_MULTIPATH reverts to the legacy naming
> > > convention. This happens in all the 4.19, 4.18 and 4.17 kernels we
> > > tested. I've not tried the for-next tree.
> >    
> >    That is expected. We still need character devices to each controller path
> >    for administration, but we don't need block devices to each namespace
> >    path, so the numbers in the controller and block handles are independent
> >    of each other.
> 
> Keith
> 
> Ooooookay. Thanks for letting us know!

Note the naming convention that's causing confusion applies to the
visible namespace paths. The hidden paths have naming convention like
"nvme<X>c<Y>n<Z>", and that <Y> value matches up the the controller
handle at /dev/nvme<Y>.

That doesn't do you any good if you're looking in /dev/ since those
paths are hidden, but the topology can be observed in /sys/.
