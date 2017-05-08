From: jsmart2021@gmail.com (James Smart)
Date: Mon, 8 May 2017 11:17:19 -0700
Subject: [PATCH 2/2] nvme_fc: add uevent for auto-connect
In-Reply-To: <3fcdf302-ac8b-779b-9660-19ab80c00ce5@suse.de>
References: <20170505231335.31726-1-jsmart2021@gmail.com>
 <20170505231335.31726-3-jsmart2021@gmail.com>
 <3fcdf302-ac8b-779b-9660-19ab80c00ce5@suse.de>
Message-ID: <6f2f5764-a58e-70dd-d790-adb950c964c1@gmail.com>

On 5/8/2017 4:17 AM, Hannes Reinecke wrote:
> On 05/06/2017 01:13 AM, jsmart2021@gmail.com wrote:
>> From: James Smart <jsmart2021 at gmail.com>
>>
>> To support auto-connecting to FC-NVME devices upon their dynamic
>> appearance, add a uevent that can kick off connection scripts.
>> uevent is posted against the nvme_fc transport device.
>>
> I'm not sure if that will work for the proposed multipath extensions for
> NVMe.

I don't know why this should conflict with multipath.


>
> From my understanding NVMe will drop all queues and do a full
> reconnection upon failure, correct?

Sure... but these are all actions "below the nvme device".

The nvme storage device presented to the OS, the namespace, is issuing 
io's to the controller block queue. When a controller errors or is lost, 
the nvme fabrics level (currently the transport) will stop the 
controller block queue and all outstanding requests are terminated and 
returned to the block queue for requeuing. The transport initially tries 
to reconnect, and if the reconnect fails, a timer is started to retry 
the reconnect in a few seconds. This repeats until a controller time 
limit expires (ctrl_loss_tmo), at which point the controller block 
queues are torn down. FC differs from RDMA in that: it won't try to 
reconnect if there isn't connectivity; and it sets the controller time 
limit to the smaller of the SCSI FC transport dev_loss_timer (passed to 
it via the driver) and the connection requested ctrl_loss_tmo.

So, while the reconnect is pending, the block queues are stopped and 
idle. If the transport successfully completes a reconnect before the 
timer expires, the controller's block queues are then released and io 
starts again.

This patch changes nothing in the behavior - it only keys the FC 
reconnect attempt to device appearance (note: if fc port is connected, 
the same timers used by rdma still occur on FC).

The patch does add one other things though.  If the time limit did 
expire and the controller was tied down, in order to "get the path back" 
a new create_controller request has to be made.  The patch does, for FC, 
key this to device appearance, so it's automated.  This is likely 
different from RDMA where a system script/daemon is periodically trying 
to connect again (device was there so keep trying to see if it comes 
back) or it depends on some administrative action to create the controller.


>
> So if there is a multipath failure NVMe will have to drop all failed
> paths and reconnect.
> Which means that if we have an all paths down scenario _all_ paths are
> down, and need to be reconnect.
> Consequently the root-fs becomes inaccessible for a brief period of
> time, and relying on things like udev to do a reconnect will probably
> not work.

As for multipathing:
1) if md-like multipathing is done, I believe it means there are 
separate nvme storage devices (each a namespaces on top of a 
controller). Thus each device is a "path". Paths would be added with the 
appearance of a new nvme storage device, and when they are torn down, 
the path would go away.  I assume multipathing would also become aware 
of when the device is "stopped/blocked" due to its controller queues 
being stopped.

2) if a lighter-weight multipathing is done, say within the nvme layer, 
the rescanning of the nvme namespaces would pair it up to the nvme 
storage device, thus each set of controller blk queues would be the 
"path". Thus, when a controller's queues are "stopped/blocked" the nvme 
device knows and stops using that path. And when they go away, the 
"path" is removed.

We could talk further about options when the last path is gone but... 
back to this patch - you'll note nothing in this section has anything to 
do with the patch. The patch changes nothing in the overall nvme device 
or controller behaviors. The only thing the patch does is specific to 
the bottom levels of the FC transport - keying reconnects and or new 
device scanning to FC target device connectivity announcements.


> Also, any other driver (with the notable exception of S/390 ones)(ok,
> and iSCSI) does an autoconnect.
> And went into _soo_ many configuration problems due to that fact.
> zfcp finally caved in and moved to autoconnect, too, precisely to avoid
> all these configuration issues.
>
> So what makes NVMe special that it cannot do autoconnect within the driver?

Well, this gets back to the response I just sent back to Johannes.  NVME 
discovery requires connecting to a discovery controller and reading 
discovery log records (sound similar to iscsi and iSNS) and from the 
discovery log records then connect to nvme subsystems resulting in the 
nvme controllers. This functionality is currently not in the kernel, 
it's in the nvme cli as the "connect-all" functionality when talking to 
a discovery controller. For FC, as it knows the presence of discovery 
controllers on the FC fabric, this patch is how we're invoking that 
functionality. Note: there's nothing in FC that would provide the 
content of the discovery log records so that it could skip the discovery 
controller connection.   For RDMA, it's lack of connectivity knowledge 
prevents it from doing auto-connect once it's torn down the controller 
after a ctrl_loss_tmo.

-- james
