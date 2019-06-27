From: jsmart2021@gmail.com (James Smart)
Date: Wed, 26 Jun 2019 17:49:45 -0700
Subject: [EXT] Re: [PATCH] nvme-fc: fix module unloads while lports still
 pending
In-Reply-To: <alpine.LRH.2.21.9999.1906261725120.7630@mvluser05.qlc.com>
References: <20190625160604.3905-1-jsmart2021@gmail.com>
 <alpine.LRH.2.21.9999.1906261516150.7630@mvluser05.qlc.com>
 <ddcc1865-4494-9cfe-d371-9995c19ae1c4@gmail.com>
 <alpine.LRH.2.21.9999.1906261638450.7630@mvluser05.qlc.com>
 <alpine.LRH.2.21.9999.1906261725120.7630@mvluser05.qlc.com>
Message-ID: <1011783c-e0c0-4dba-824e-821bf5b4955f@gmail.com>

On 6/26/2019 5:28 PM, Arun Easi wrote:
> Attaching the patch I was referring earlier. Maybe the infinite loop in
> exit could be changed to a time bound one.
> 
> -Arun
> 

Interesting. I still prefer the stronger referencing while anything is 
outstanding as I think it's really ugly to get into __exit at all when 
things haven't cleaned up, and once in __exit, there's no going back.
Also concerned with:
- hopefully module load checking prevents loading of another lldd
   while in this state. Ugly for that thing if its rejected and the
   load has to be retried.
- I don't like the long delays (could be a minute plus) for unload 
command while it waits - anyone stuck in the wait will be asking 
questions as to why
- Exiting after a time delay isn't great as it's just as bad as the 
existing code that left with things not cleaned up. I was hoping to 
correct that.

-- james
