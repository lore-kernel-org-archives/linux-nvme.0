From: gpiccoli@linux.vnet.ibm.com (Guilherme G. Piccoli)
Date: Wed, 6 Jul 2016 19:47:14 -0300
Subject: [PATCH 2/2] [RFC] nvme: enable asynchronous events notification
 by default
In-Reply-To: <20160624081726.GA13596@infradead.org>
References: <1466184075-10471-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1466184075-10471-3-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <57679355.6000303@gmail.com> <576821E9.2060009@linux.vnet.ibm.com>
 <20160620202135.GG12936@localhost.localdomain>
 <20160624081726.GA13596@infradead.org>
Message-ID: <577D8A72.5010701@linux.vnet.ibm.com>

On 06/24/2016 05:17 AM, Christoph Hellwig wrote:
> On Mon, Jun 20, 2016@04:21:35PM -0400, Keith Busch wrote:
>> Instead of simply logging a message, is there something better we can do
>> to notify a user of an async event result? The event should be masked
>> by the controller until the appropriate log page is read, and I don't
>> think scanning the kernel logs is how such a program wants to find out
>> which page to read.
>
> Yes, I'm not too excited about handling the AERs in kernel space,
> having a userspace daemon to listen for them would generally be more
> useful.

Thanks very much for all the replies - sorry for the delay in my response.

I guess we have 2 ways of dealing with those events, one being from 
kernel, the other by working in a daemon like Krisman mentioned (the IPR 
case). Both approaches seems to have their importance; an automatic 
error reporting tool might schedule greps on dmesg to find errors, so it 
can be useful showing them on kernel logs. More yet, some critical 
errors should be reported on kernel logs always, IMHO (like the adapter 
persistent error).

On the other hand, daemons seem to be a better accepted solution (as per 
this thread's comments hehe) and they are more popular maybe. So 2 
possible implementations come to my mind, one not excluding the other. 
I'll elaborate below, but since they can work concomitantly, I'd go for 
implementing both.


(i) We can implement a daemon like Krisman suggested, that uses uevents 
and reads the last async event from a sysfs entry, cleaning the 
necessary bit to allow more events to be reported;

(ii) We can implement a special sysfs parameter that defaults to 0, 
allowing the use of (i). This parameter is a timeout, in seconds - when 
this is set to a value >0, approach (i) is disabled, and we start to 
monitor the events from the driver. Once an event is captured, we print 
it on kernel log, wait the timeout and clear the necessary bit to allow 
new events to be reported, and so on...allowing this way a dmesg events 
approach, without flooding the log or inhibiting the users that prefer (i).


Comments and suggestions are much appreciated.
Thanks in advance,



Guilherme


> The only exception is the namespace changed AER that we already handle.
> But while we're at it: why do we make use of the changed namespace
> list log page in this case instead of doing a full recan.
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>
