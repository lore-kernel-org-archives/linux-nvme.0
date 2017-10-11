From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 11 Oct 2017 13:29:59 +0300
Subject: [PATCH v2 7/7] nvme_fc: add dev_loss_tmo timeout and remoteport
 resume support
In-Reply-To: <20170927045046.22238-8-jsmart2021@gmail.com>
References: <20170927045046.22238-1-jsmart2021@gmail.com>
 <20170927045046.22238-8-jsmart2021@gmail.com>
Message-ID: <88124a13-30d4-8906-f9c7-6c00d6d7ee31@grimberg.me>


> This patch adds the dev_loss_tmo functionality to the transport.
> 
> When a remoteport is unregistered (connectivity lost), it is marked
> DELETED and the following is perfomed on all the controllers on the
> remoteport:
> - the controller is reset to delete the current association.
> - Once the association is terminated, the dev_loss_tmo timer is started.
>    A reconnect is not scheduled as there is no connectivity.
>    Note: the start of the dev_loss_tmo timer is in the generic
>    delete-association/create-new-association path. Thus it will be started
>    regardless of whether the reset was due to remote port connectivity
>    loss, a controller reset, or a transport run-time error.
> 
> When a remoteport is registered (connectivity established), the
> transport searches the list of remoteport structures that have pending
> deletions (controllers waiting to have dev_loss_tmo fire, thus
> preventing remoteport deletion). The transport looks for a matching
> wwnn/wwpn. If one is found, the remoteport is transitioned back to
> ONLINE, and the following occurs on all controllers on the remoteport:
> - any controllers in a RECONNECTING state have reconnection attempts
>    kicked off.
> - If the controller was RESETTING, it's natural RECONNECTING transition
>    will start a reconnect attempt.

OK, I think I finally understand the existence of the two tmos.
But may I ask, what happens if we only have ctrl_loss_tmo support?

If I understand correctly, it would behave exactly as expected as the
controller will periodically attempt reconnect until ctrl_loss_tmo fires
and then it is deleted. With dev_loss_tmo, once the lower between
ctrl_loss_tmo and dev_loss_tmo expires, the controller is deleted.
If my understanding is correct, this just adds a level of confusion
to setup procedure doesn't it?
