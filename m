From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 24 Aug 2016 13:40:45 +0300
Subject: nvmf host shutdown hangs when nvmf controllers are in
 recovery/reconnect
In-Reply-To: <00de01d1fd4d$10e44700$32acd500$@opengridcomputing.com>
References: <00de01d1fd4d$10e44700$32acd500$@opengridcomputing.com>
Message-ID: <b93e8bc6-1fd1-3191-d811-1503cc2e4499@grimberg.me>


> Hey guys, when I force an nvmf host into kato recovery/reconnect mode by killing
> the target, and then reboot the host, it hangs forever because the nvmf host
> controllers never get a delete command, so they stay stuck in reconnect state.

Hey Steve,

For some reason I can't reproduce this on my setup...

So I'm wandering where is nvme_rdma_del_ctrl() thread stuck?
Probably a dump of all the kworkers would be helpful here:

$ pids=`ps -ef | grep kworker | grep -v grep | awk {'print $2'}`
$ for p in $pids; do echo "$p:" ;cat /proc/$p/stack; done

The fact that nvme1 keeps reconnecting forever, means that
del_ctrl() never changes the controller state. Is there an
nvme0 on the system that is also being removed and you don't
see the reconnecting thread keeps on going?

My expectation would be that del_ctrl() would move the ctrl state
to DELETING and reconnect thread would bail-out, then the delete_work
should fire and delete the controller. Obviously something is not
happening like it should.
