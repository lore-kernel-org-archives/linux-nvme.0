From: sbates@raithlin.com (Stephen  Bates)
Date: Mon, 29 Oct 2018 15:48:52 +0000
Subject: [PATCH 2/2] nvme/multipath: Fix multipath disabled naming
 collisions
In-Reply-To: <20181029154229.GA16586@localhost.localdomain>
References: <20180426214956.3377-1-keith.busch@intel.com>
 <20180426214956.3377-3-keith.busch@intel.com>
 <CAD4F464-15CC-44B9-9C72-B5F2BDFC5445@raithlin.com>
 <20181029154229.GA16586@localhost.localdomain>
Message-ID: <DA56163F-C776-4A11-AFF0-2A29B68120A8@raithlin.com>

> > Note how the /nvme/nvme0/ sysfs directory contains the nvme1n1
> > namespace. Is this expected? I am not that familiar with the multipath
> > code so I'm not sure if this is a bug or not but it sure is confusing.
> > Disabling CONFIG_NVME_MULTIPATH reverts to the legacy naming
> > convention. This happens in all the 4.19, 4.18 and 4.17 kernels we
> > tested. I've not tried the for-next tree.
>    
>    That is expected. We still need character devices to each controller path
>    for administration, but we don't need block devices to each namespace
>    path, so the numbers in the controller and block handles are independent
>    of each other.

Keith

Ooooookay. Thanks for letting us know!

Stephen
    
