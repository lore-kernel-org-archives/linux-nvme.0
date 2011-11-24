From: willy@linux.intel.com (Matthew Wilcox)
Date: Thu, 24 Nov 2011 13:06:31 -0500
Subject: LBA Range handling
In-Reply-To: <5AC4D6A45304E048A30F105EB302760902CBB1D2@CORPEXCH1.na.ads.idt.com>
References: <5AC4D6A45304E048A30F105EB302760902CBB0AF@CORPEXCH1.na.ads.idt.com>
 <20111123213447.GB14291@linux.intel.com>
 <5AC4D6A45304E048A30F105EB302760902CBB1D2@CORPEXCH1.na.ads.idt.com>
Message-ID: <20111124180631.GD14291@linux.intel.com>

On Wed, Nov 23, 2011@01:47:20PM -0800, Kong, Kwok wrote:
> Actually, I am not sure how do use the LBA range.  Who should set the
> LBA Range ? Should it be the driver or the application ?  What should
> the driver behave if the type is 'page cache', 'RAID', 'Reserved' or
> 'FILESYSTEM' ?
> 
> How are we supposed to use the LBA range ?

My understanding is that there will be a user-space application (like
fdisk) that will write the LBA Range Type attribute.  The 'type' is
mostly for the benefit of this application and shouldn't be interpreted
by the driver.
