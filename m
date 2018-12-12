From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 12 Dec 2018 09:58:41 -0800
Subject: [PATCH v2 0/5] implement nvmf read/write queue maps
In-Reply-To: <477ef7e7-bc81-5c27-84ba-27c75989bdc4@broadcom.com>
References: <20181211233519.9350-1-sagi@grimberg.me>
 <477ef7e7-bc81-5c27-84ba-27c75989bdc4@broadcom.com>
Message-ID: <be43de64-eb4b-c116-85f2-8c5d5a62e3c1@grimberg.me>


> Sagi,
> 
> What other wins are there for this split ?
> 
> I'm considering whether its worthwhile for fc as well, but the hol issue 
> doesn't exist with fc. What else is being resolved ?

I've pondered it myself, which is why I didn't add it to fc as well
(would have been easy enough I think). I guess that with this the
user can limit writes compared to read by assigning less queues as
jens suggested in his patches...
