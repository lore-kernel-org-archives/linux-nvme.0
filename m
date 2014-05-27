From: keith.busch@intel.com (Keith Busch)
Date: Mon, 26 May 2014 23:50:45 -0600 (MDT)
Subject: [PATCH] NVMe: Add support to receive NVMe asynchronous events
In-Reply-To: <53842414.7020207@micron.com>
References: <53839E67.1010006@micron.com>
 <20140526235156.GS6121@linux.intel.com>
 <alpine.LRH.2.03.1405261834070.4700@AMR> <53842414.7020207@micron.com>
Message-ID: <alpine.LRH.2.03.1405262337230.4700@AMR>

On Mon, 26 May 2014, Winson Yung (wyung) wrote:
> Keith, I do see a need to enable async event in the NVMe kernel driver. For 
> example, when there is a temperature above threshold, driver can take an 
> action (by telling firmware) to lower down operating frequency, or throttle 
> IO request to protect drive from premature over heat damage.

This is sounding specific to your environment. What's a good policy
for yours might not be a good policy for mine. Why would I want the
driver to throttle frequency when I have better environmental control
options available? The right thing to do, IMHO, is make all information
available to a user space app and provide a way for it to control the
device according to a policy it knows.
