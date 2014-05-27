From: raymond.c.robles@intel.com (Robles, Raymond C)
Date: Tue, 27 May 2014 06:56:37 +0000
Subject: [PATCH] NVMe: Add support to receive NVMe asynchronous events
In-Reply-To: <alpine.LRH.2.03.1405262337230.4700@AMR>
References: <53839E67.1010006@micron.com>
 <20140526235156.GS6121@linux.intel.com>
 <alpine.LRH.2.03.1405261834070.4700@AMR> <53842414.7020207@micron.com>
 <alpine.LRH.2.03.1405262337230.4700@AMR>
Message-ID: <49158E750348AA499168FD41D889836063171C61@fmsmsx117.amr.corp.intel.com>

This is exactly what the Windows OFA NVMe open source driver does as well. The driver does not, and should not, have knowledge as to what the "right temperature threshold" is or how many "I/O to throttle" in any kind of situation, good or bad. The NVMe device/controller parameters and policy should be set and handled (proactively and reactively) by the device vendor and any 3rd party user space application, either from the vendor or some other trusted OEM source. 

-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of Keith Busch
Sent: Monday, May 26, 2014 10:51 PM
To: Winson Yung (wyung)
Cc: Busch, Keith; Matthew Wilcox; linux-nvme at lists.infradead.org
Subject: Re: [PATCH] NVMe: Add support to receive NVMe asynchronous events

On Mon, 26 May 2014, Winson Yung (wyung) wrote:
> Keith, I do see a need to enable async event in the NVMe kernel 
> driver. For example, when there is a temperature above threshold, 
> driver can take an action (by telling firmware) to lower down 
> operating frequency, or throttle IO request to protect drive from premature over heat damage.

This is sounding specific to your environment. What's a good policy for yours might not be a good policy for mine. Why would I want the driver to throttle frequency when I have better environmental control options available? The right thing to do, IMHO, is make all information available to a user space app and provide a way for it to control the device according to a policy it knows.

_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
