From: jsmart2021@gmail.com (James Smart)
Date: Wed, 26 Jun 2019 16:00:48 -0700
Subject: [PATCH] nvme-fc: fix module unloads while lports still pending
In-Reply-To: <alpine.LRH.2.21.9999.1906261516150.7630@mvluser05.qlc.com>
References: <20190625160604.3905-1-jsmart2021@gmail.com>
 <alpine.LRH.2.21.9999.1906261516150.7630@mvluser05.qlc.com>
Message-ID: <ddcc1865-4494-9cfe-d371-9995c19ae1c4@gmail.com>

On 6/26/2019 3:20 PM, Arun Easi wrote:
> Changes look ok.
> 
> Did you hit this during testing? Wondering because LLD would have unloaded
> prior to nvme_fc, so no lport/rport should remain if LLD behaves well.
> 
> -Arun
> 

It's been a longstanding annoyance - usually tied with test cases that 
used modprobe -r.   Issue is the drivers would call the targetport 
unregister calls, which would release the targetport once all the 
outstanding ios were cancelled to the lldd and the link-side association 
terminated, but the controllers are in a reconnecting and not yet torn 
down. From the drivers point of view, they are unlinked. Thus it was 
intended the driver could unregister/unload/reload/reregister and if 
possible reconnect - allowing the nvme device to never be deleted. Given 
the lack of module reference, when the driver module left, so did the 
transport module, even with the live data structures.

-- james
