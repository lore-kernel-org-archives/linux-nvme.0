From: wes@sol1.com.au (Wes Cilldhaire)
Date: Wed, 25 Nov 2015 11:21:13 +1100 (EST)
Subject: [PATCH v2] nvme: temporary fix for Apple controller reset
In-Reply-To: <20151122085656.GA17762@infradead.org>
References: <781f695dc3cedc678faf29070a6f6bf5@localhost>
 <20151122085656.GA17762@infradead.org>
Message-ID: <15698712.209954.1448410873661.JavaMail.zimbra@sol1.com.au>


I can confirm this works around the controller reset issue for me on macbook8,1 , and doesn't clobber my linux or other file systems (I have a triple boot setup with osx, win10 and linux).
Previously I was seeing the reset almost immediately due to the high amount of IO systemd seems to create during boot, or after a couple minutes when booting with openrc.  Now both boot without issue all the way to KDE init.  I've tried an fstrim, partprobes, and dd'ing to generate some writes for an extended time all without issue and all file systems appear healthy.

Cheers,
Wes Cilldhaire



----- Original Message -----
From: "Christoph Hellwig" <hch@infradead.org>
To: "Stephan G??nther" <guenther at tum.de>
Cc: "Matthew Wilcox" <willy at linux.intel.com>, linux-nvme at lists.infradead.org, "Jon Derrick" <jonathan.derrick at intel.com>, "Maurice Leclaire" <leclaire at in.tum.de>
Sent: Sunday, 22 November, 2015 7:56:56 PM
Subject: Re: [PATCH v2] nvme: temporary fix for Apple controller reset

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>

_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
