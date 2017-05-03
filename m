From: jsmart2021@gmail.com (James Smart)
Date: Wed, 3 May 2017 08:32:56 -0700
Subject: [PATCH] nvme core: allow controller RESETTING to RECONNECTING
 transition
In-Reply-To: <fa1b98e7-9751-885e-a2b0-a1918779cf2a@grimberg.me>
References: <20170502185458.3495-1-jsmart2021@gmail.com>
 <fa1b98e7-9751-885e-a2b0-a1918779cf2a@grimberg.me>
Message-ID: <ce7a80c3-e746-cffc-7624-b013a94bca73@gmail.com>

On 5/3/2017 12:59 AM, Sagi Grimberg wrote:
>
>> Allow controller state transition : RESETTING to RECONNECTING
>>
>> I intend to have the nvme_fc transport set the state to RESETTING when
>> tearing down the current association (error or controller reset), then
>> transitioning to RECONNECTING when attempting to establish a new
>> association.
>
> I'm not sure this is a good idea. I think that the semantics of
> RESETTING state is that we are performing a controller reset,
> RECONNECTING semantics means we are trying to reestablish our controller
> session. It seems that mixing these states is just confusing.

I'm not following as, at a high level, it sounds like we're saying the 
same thing. I'm sure the difference is in the definitions of "controller 
reset" and "reestablish our controller session".

here's how I view them:

RESETTING: stopping the blk queues, killing the transport 
queues/connections and outstanding io on them, then formally tearing 
down the fabric association.  Officially, RESETTING would be when 
CC.EN=0 is done. But that can only occur if there is connectivity to the 
target and can use the admin connection for a Set_Property command. All 
the same actions take place except the Set_Property on cases where you 
lose connectivity. I'm viewing all of these actions, of terminating the 
original transport association, as RESETTING.

RECONNECTING: restarting the association - creating transport 
queues/connections, reprobing the controller and re-releasing block 
queues. I'm viewing all of the actions to create a new transport 
association, as RECONNECTING.

on FC, I was going to: move the controller from LIVE->RESETTING when 
tearing down the association, whether invoked by the core reset 
interface or upon detecting an error and independent of whether I can 
send an CC.EN=0 (which I'll do if connected); and after teardown, from 
RESETTING->CONNECTING as I start the new association. And if the new 
association can't be immediately created: a) if there is connectivity, 
use the same periodic retry based on max_reconnects and reconnect_delay; 
and b) if there isn't connectivity, delay until connectivity occurs or a 
timeout.


I find it more confusing with what rdma has:

RESETTING: When invoked by core layer to reset the ctrl. stops block 
queues, kills transport queues/connections and outstanding ios, attempts 
immediate new association with target, creating transport 
queues/connections and releasing io. AND if new association fails, 
device is deleted.

RECONNECTING: transport error detected. stops block queues, kills 
transport queues/connections and outstanding ios, attempts new 
association with target, creating transport queues/connections and 
releasing io. AND if new association fails, retries the new association 
connect per max_reconnects/reconnect_delay before giving up.

As I interpret them, the states reflect why/how it was torn 
down/reconnecting (core layer invoked and CC.EN written vs transport 
detected/deleted), and whether a reconnect will be retried or not. State 
of what its doing is lost a bit.


>
> In fact, I have a patch in the pipe that disallows the state transition
> from RECONNECTING to RESETTING:

I don't have any problem with this.

-- james
