From: keith.busch@intel.com (Keith Busch)
Date: Wed, 18 Feb 2015 22:45:53 +0000 (UTC)
Subject: Async Event test
In-Reply-To: <54E4C2CD.3090308@gmail.com>
References: <54E4C2CD.3090308@gmail.com>
Message-ID: <alpine.LNX.2.00.1502182237380.32385@localhost.lm.intel.com>

On Wed, 18 Feb 2015, Olivier Mallinger wrote:
> Hello.
>
> I want to test the asynchronous event xith my controller.
> Has this feature been implemented in the Linux driver ?
>
> I want to request asynchronous event to my controller, then I will instrument 
> my controller to simulate event.
> I don't know what is going to do the driver in such case and how to have 
> access to the asynchronous event information.
> Do you have any solutions to test it ?

The driver submits mutliple async requests. The number sent is either
the device's max or 8, which ever is smaller. When the driver sees a
completion, it writes a message to the kernel log then submits another
request. If anyone has a better idea how to report async events, I'm
all for it.

To test, I just set the temperature threshold to below the current
temparature to trigger the smart async event.
