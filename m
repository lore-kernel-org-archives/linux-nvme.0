From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 16 Mar 2017 18:40:30 +0200
Subject: kernull NULL pointer observed on initiator side after 'nvmetcli
 clear' on target side
In-Reply-To: <7a955472-1975-1b73-c88c-367576a56884@redhat.com>
References: <1053522223.31446389.1488721184925.JavaMail.zimbra@redhat.com>
 <644fc4ab-df6b-a337-1431-bad881ef56ee@grimberg.me>
 <88ae146a-7510-9be0-c9b4-58e70f9d73b9@redhat.com>
 <6ffda302-02f9-12f0-a112-ea7cd20b9ffa@grimberg.me>
 <b0a84bcc-7dca-d342-b30e-b01eba8088cd@redhat.com>
 <6fe6d285-3cb4-c88c-9a7c-741fce54120c@grimberg.me>
 <7a955472-1975-1b73-c88c-367576a56884@redhat.com>
Message-ID: <bbb45ff5-8b61-2508-df4a-7c90eb6637de@grimberg.me>


> The target was deleted by 'nvmetcli clear' command.
> Then on client side, seems it doesn't know the target side was deleted
> and will always reconnecting in 10 seconds.

Oh, so the target doesn't come back. That makes sense. The host
doesn't know if/when the target will come back so it attempts reconnect
periodically forever.

I think what you're asking is a "dev_loss_tmo" kind of functionality
where the host gives up on the controller correct?
