From: james.smart@broadcom.com (James Smart)
Date: Wed, 11 Jul 2018 16:23:01 -0700
Subject: [PATCHv2 0/8] nvme timeout fixes v2
In-Reply-To: <20180523224946.GF11037@localhost.localdomain>
References: <20180522220332.9244-1-keith.busch@intel.com>
 <20180523030057.GF31196@ming.t460p>
 <20180523161614.GE11037@localhost.localdomain>
 <20180523224946.GF11037@localhost.localdomain>
Message-ID: <5e724f53-107f-f295-77dd-243a2f2fc9aa@broadcom.com>

On 5/23/2018 3:49 PM, Keith Busch wrote:
> On Wed, May 23, 2018@10:16:14AM -0600, Keith Busch wrote:
>> On Wed, May 23, 2018@11:00:59AM +0800, Ming Lei wrote:
>>> Looks V2 still may trigger IO hang warning:
>> Anything in particular that triggered this?
>>
>> I'm running IO with io-timeout fault injection, with resets and rescans
>> randomly running in the background, so I'm guessing that's not enough.
> At the very least, I can see allowing CONNECTING->RESETTING transitions
> was a terrible idea. I can get other failures because of that, but not
> quite what you're seeing.

Is there another way to resolve these terrible ideas ?

I can see this transition as being a very useful for the case where I'm 
in CONNECTING but one of the commands to init the controller gets an io 
error or timeout (ex fabric Connect command gets lost) thus I need to 
"reset" (kill all io for current association) and restart CONNECTING.? 
With the transition, I can use the singular code path that is there 
already. Without it, I have to duplicate the reset entry point so I can 
call it, perform the same work, yet stay in the CONNECTING state - which 
seems an odd thing to do.

Note: this may be related to the timeout handler. in my case, I always 
return BLK_EH_RESET_TIMER as the best the timeout handler can do is 
initiate the hw action to abort the io so that it will finish sometime 
in the very near future and to request the controller to reset/change 
state. The reset never finishes until all ios complete, which means it 
waits for those aborted ios to come back from the hw.

-- james
