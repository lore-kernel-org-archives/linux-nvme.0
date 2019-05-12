From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 12 May 2019 08:08:05 -0700
Subject: [PATCH nvme-cli rfc 3/5] fabrics: allow discover to address
 discovery controller by persistent name
In-Reply-To: <c3bf6edd-91fc-74d5-29a3-093fa57d561f@suse.de>
References: <20190504000456.3888-1-jsmart2021@gmail.com>
 <20190504000456.3888-4-jsmart2021@gmail.com>
 <28e1e9a8-671d-e3ff-6111-7561e0f56fa9@suse.de>
 <1154a16f-222e-7a28-96c0-3a22052e2bef@broadcom.com>
 <f51f039e-24f2-d01f-2ae1-9f86c99e00e2@suse.de>
 <3f84d637-4d04-45e1-ce49-59238c2aaea8@broadcom.com>
 <c3bf6edd-91fc-74d5-29a3-093fa57d561f@suse.de>
Message-ID: <689b9665-5f93-1ccc-3e6b-41436b769b09@grimberg.me>


> You're talking about discovery referrals, right?
> In this case I'd go with case a), and simply create non-persistent 
> connection.
> Reasoning is that if the admin wants to have a persistent discovery he 
> should be ensuring that this secondary controller is found during inital 
> discovery (ie with the abovementioned systemd boot service).
> 
> (And discovery referrals are tricky anyway; I've created two discovery 
> controllers each having a reference to the other nice in order to have a 
> failover scenario, but ended up with a looping nvme connect-all ... need 
> to send a patch for that.)

Hmm...

I see two options here:
1. create new transient discovery controller for each referral as we do
today.
2. make --persistent follow referrals such that we have persistent
device for each and then we skip referrals as we will expect events
coming from them...

I would suggest (1) as its simpler.
