From: javier@javigon.com (=?utf-8?Q?Javier_Gonz=C3=A1lez?=)
Date: Tue, 29 Jan 2019 09:25:17 +0100
Subject: [LSF/MM TOPIC] Zoned Block Devices
In-Reply-To: <714fc666-c562-83c2-c1a3-19f1dd47d1d9@wdc.com>
References: <714fc666-c562-83c2-c1a3-19f1dd47d1d9@wdc.com>
Message-ID: <F88F3B28-4CC8-4B54-AE2F-341936C0C184@javigon.com>

> On 28 Jan 2019,@13.56, Matias Bjorling <Matias.Bjorling@wdc.com> wrote:
> 
> Hi,
> 
> Damien and I would like to propose a couple of topics centering around
> zoned block devices:
> 
> 1) Zoned block devices require that writes to a zone are sequential. If
> the writes are dispatched to the device out of order, the drive rejects
> the write with a write failure.
> 
> So far it has been the responsibility the deadline I/O scheduler to
> serialize writes to zones to avoid intra-zone write command reordering.
> This I/O scheduler based approach has worked so far for HDDs, but we can
> do better for multi-queue devices. NVMe has support for multiple queues,
> and one could dedicate a single queue to writes alone. Furthermore, the
> queue is processed in-order, enabling the host to serialize writes on
> the queue, instead of issuing them one by one. We like to gather
> feedback on this approach (new HCTX_TYPE_WRITE).
> 
> 2) Adoption of Zone Append in file-systems and user-space applications.
> 
> A Zone Append command, together with Zoned Namespaces, is being defined
> in the NVMe workgroup. The new command allows one to automatically
> direct writes to a zone write pointer position, similarly to writing to
> a file open with O_APPEND. With this write append command, the drive
> returns where data was written in the zone. Providing two benefits:
> 
> (A) It moves the fine-grained logical block allocation in file-systems
> to the device side. A file-system continues to do coarse-grained logical
> block allocation, but the specific LBAs where data is written and
> reported from the device. Thus improving file-system performance. The
> current target is XFS but we would like to hear the feasibility of it
> being used in other file-systems.
> 
> (B) It lets host issue multiple outstanding write I/Os to a zone,
> without having to maintain I/O order. Thus, improving the performance of
> the drive, but also reducing the need for zone locking on the host side.
> 
> Is there other use-cases for this, and will an interface like this be
> valuable
> in the kernel? If the interface is successful, we would expect the
> interface to move to ATA/SCSI for standardization as well.
> 
> Thanks, Matias

This topic is of interest to me as well.

For the append command, I think we also need to discuss the error model
as writes should be able to fail (e.g., a zone has shrink due to
previous, hidden, write errors and the host has not updated the zone
metadata).

Thanks,
Javier
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Message signed with OpenPGP
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20190129/487a7847/attachment-0001.sig>
