From: Matias.Bjorling@wdc.com (Matias Bjorling)
Date: Mon, 28 Jan 2019 12:56:25 +0000
Subject: [LSF/MM TOPIC] Zoned Block Devices
Message-ID: <714fc666-c562-83c2-c1a3-19f1dd47d1d9@wdc.com>

Hi,

Damien and I would like to propose a couple of topics centering around 
zoned block devices:

1) Zoned block devices require that writes to a zone are sequential. If 
the writes are dispatched to the device out of order, the drive rejects 
the write with a write failure.

So far it has been the responsibility the deadline I/O scheduler to 
serialize writes to zones to avoid intra-zone write command reordering. 
This I/O scheduler based approach has worked so far for HDDs, but we can 
do better for multi-queue devices. NVMe has support for multiple queues, 
and one could dedicate a single queue to writes alone. Furthermore, the 
queue is processed in-order, enabling the host to serialize writes on 
the queue, instead of issuing them one by one. We like to gather 
feedback on this approach (new HCTX_TYPE_WRITE).

2) Adoption of Zone Append in file-systems and user-space applications.

A Zone Append command, together with Zoned Namespaces, is being defined 
in the NVMe workgroup. The new command allows one to automatically 
direct writes to a zone write pointer position, similarly to writing to 
a file open with O_APPEND. With this write append command, the drive 
returns where data was written in the zone. Providing two benefits:

(A) It moves the fine-grained logical block allocation in file-systems 
to the device side. A file-system continues to do coarse-grained logical 
block allocation, but the specific LBAs where data is written and 
reported from the device. Thus improving file-system performance. The 
current target is XFS but we would like to hear the feasibility of it 
being used in other file-systems.

(B) It lets host issue multiple outstanding write I/Os to a zone, 
without having to maintain I/O order. Thus, improving the performance of 
the drive, but also reducing the need for zone locking on the host side.

Is there other use-cases for this, and will an interface like this be 
valuable
in the kernel? If the interface is successful, we would expect the 
interface to move to ATA/SCSI for standardization as well.

Thanks, Matias
