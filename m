From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 16 Nov 2017 17:49:42 +0200
Subject: [PATCH 4/4] nvmet: Add feature close connection from target side
In-Reply-To: <ca29c79a-0737-4e90-f2c4-d22d0f054547@mellanox.com>
References: <1510576183-17215-1-git-send-email-israelr@mellanox.com>
 <1510576183-17215-5-git-send-email-israelr@mellanox.com>
 <6279e907-06df-34dc-ab63-9c4b9ed94f6b@grimberg.me>
 <ca29c79a-0737-4e90-f2c4-d22d0f054547@mellanox.com>
Message-ID: <ef34b468-8a34-1f6f-b782-2840f8318fcf@grimberg.me>


>> What guarantees that calling delete_ctrl is safe here? Controllers can
>> be freed under various conditions (client disconnect, fatal_error,
>> device removal). What protects from user initiated force_close hitting
>> a use-after-free condition?
> 
> The fact that I call nvmet_ctrl_configfs_del() at nvmet_ctrl_free() 
> before freeing the controller guarantees
> that the user will not see the controller at the filesystem after this 
> point.
> The second thing is that configfs_unregister_group() should wait for all 
> the user calls on the controller to finish.
> I don't see a difference between nvmet_ctrl_trsvcid_show() and 
> nvmet_ctrl_force_close_store() (both are synchronous functions).
> 
> Regarding the races that you mentioned with client disconnect, 
> fatal_error ...
> __nvmet_rdma_queue_disconnect() is protected with a state lock.

The point is that ->delete_ctrl() is not designed to be safe for
calling it multiple times (although it might be the case for rdma) and
the code assumes that (which is wrong).

You need to call it conditionally. See what is done in
nvmet_ctrl_fatal_error()
