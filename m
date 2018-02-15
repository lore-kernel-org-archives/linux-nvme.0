From: suganath-prabu.subramani@broadcom.com (Suganath Prabu Subramani)
Date: Thu, 15 Feb 2018 14:11:55 +0530
Subject: [V1 0/6] mpt3sas: Adding MPI Endpoint device support.
In-Reply-To: <1518000710-17256-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1518000710-17256-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Message-ID: <CA+RiK65=fhqct22rgw8_PLaLWaN92tKF=DVCr3RVsMGe7DOxMw@mail.gmail.com>

Gentle Reminder, Any update on this ?

Thanks,
Suganath Prabu S

On Wed, Feb 7, 2018 at 4:21 PM, Suganath Prabu S
<suganath-prabu.subramani@broadcom.com> wrote:
> V1 Change info:
>
> * Few sparse warning fixes over initial patch set.
> * For 32 bit Arch,_base_writeq function is identical
> to _base_mpi_ep_writeq, Removed duplicate code as suggested by Martin.
>
> Andromeda is a PCIe switch, and it has a dedicated management
>  CPU (mCPU), nonvolatile flash memory, RAM etc... and
>  Linux kernel runs on mCPU. MPI Endpoint driver is the
>  management driver for Andromeda.
>
> The Plx Manager driver running on mCPU synthesizes a
>  virtual/Synthetic MPI End point to host.
> Synthetic MPI End point is emulated IT firmware running on
>  Linux operating system, which interfaces with PLX management
>  driver.
>
> PLX Management driver integrates IOCFW in same driver binary.
> At the end of Plx_Mgr driver load, it initializes IOC FW as well.
> Current implementation is single instance
>  of IOC FW (as it supports only one host).
>
>  PLX management driver will provide required resources
> and infrastructure for Synthetic MPI End point.
>
> Existing PLXManagement driver will reserve virtual slot for
>  MPI end point. currently, Virtual slot number 29 is reserved
>  for MPI end point.
>
> Synthetic device in management driver will be marked as
>  new type ?PLX_DEV_TYPE_SYNTH_MPI_EP?. PLXmanagement driver
>  will interface with Synthetic MPI Endpoint for any
>  communication happening on PLX_DEV_TYPE_SYNTH_MPI_EP device
>  type from host.
>
> Link between host and PLX C2 is in below diagram.
>
>                                  _______________
>  _______________                |               |
> |               |               |               |
> | PLX C2        |===============|    HOST       |
> | PCI -         |===============|   MACHINE     |
> |  SWITCH       |               |               |
> |_______________|               |               |
>         ||                      |_______________|
>         ||
>         ||
>  _______||______
> |               |
> |  MCPU         |
> |               |
> |_______________|
>
>
>
>  After MPI end point implementation -
> (Host will see dedicated Virtual SLOT as MPI End point.)
> In Below single line is logical channel for MPI Endpoint
>                                  _______________
>  _______________                |               |
> |               |               |               |
> | PLX C2        |===============|   HOST        |
> | PCI -         |===============|   MACHINE     |
> |  SWITCH       |               |               |
> |               |               |  -----------  |
> |_______________|---------------| | IT DRIVER | |
>         ||  |                   |  -----------  |
>         ||  |                   |_______________|
>         ||  |
>         ||  |
>  _______||__|___________
> |       ||  |           |
> |      MCPU |           |
> |        ___|____       |
> |       | PLX MGR|      |
> |       | DRIVER |      |
> |       |________|      |
> |           |           |
> |        ___|_____      |
> |       |         |     |
> |       |IOC FW   |     |
> |       |_________|     |
> |_______________________|
>
> PLXmanagement driver will create MPI end point based on
>  device table definition. PLXManagement driver will also
>  populate Synthetic device tree based on Device Table
>  for each host.
>
> From host it will be seen as IT HBA (Simplified version of SAS2/MPI2)
> (PCI Device, in which emulated IT FW running on mCPU behind Synthetic
>  endpoint of PCISWITCH). For host it is considered as actual
>  Physical Device.
>
> PLX Management driver provide interface to do DMA from mCPU to Host
>  using ?MCPU Response Data Buffer? method. DMA from Host to mCPU using
>  ?MCPU Response Data Buffer? is not possible.
>
> Why DMA from host to mCPU is not possible using Responsebuffer ?
>  MCPU Response buffer is not really for reading from host
>  (reading will work, but answer TLP will not come back to the CSR FIFO,
>  but will go to the MCPU root complex - which could be an
>  unexpected read completion!
>
> Existing host driver (mpt2sas) will not work
>  for MPI end point. As the interface to DMA from host to mCPU is
>  not present for Mcpu/MPI Endpoint device, To overcome this
>  Driver should do double copy of those buffer directly to the
>  mCPU memory region via BAR-0 region.
>
> The host BAR0 region is divided into different group to serve Host
>  assisted DMA.
>
>  0    - 255     System register(Doorbell, Host Interrupt etc)
>  256  - 4352    MPI Frame. (This is based on maxCredit 32)
>  4352 - 4864    Reply_free pool (512 byte is reserved considering
>                 maxCredit 32. Reply needsextra room, for mCPU case
>                 kept four times of maxCredit)
>  4864 -17152    SGE chain element.
>                 (32 command * 3 chain of 128 byte size = 12288)
>  17152 -x       Host buffer mapped with smid.
>                 (Each smid can have 64K Max IO.)
> BAR0+Last 1K    MSIX Addr and DataTotalsize in use 2113664 bytes
>                 of 4MB BAR0 MPI end point module of PLX management
>                 driver must be aware of regions above.
>
> SGE and Host buffer details will be available in MPI frame.
>
> Each PCI packets coming from host on MPI end point will end up in
>  mCPU PLXmanagement driver. We can consider this as front end for IOC FW.
>  PLXManagementdriver will call IOC front end API which will be the entry
>  point in IOC FW module. Once PLX management calls relevant callbackfrom
>  IOC FW, rest of the processing will behandled within IOC FW.
>  IOC FW should release TLP packet as soon as possible to avoid any
>  TLP timeout.
>
> Suganath Prabu S (6):
>   mpt3sas: Add PCI device ID for Andromeda.
>   mpt3sas: Configure reply post queue depth, DMA and sgl      tablesize.
>   mpt3sas: Introduce API's to get BAR0 mapped buffer      address.
>   mpt3sas: Introduce Base function for cloning.
>   mpt3sas: Introduce function to clone mpi request.
>   mpt3sas: Introduce function to clone mpi reply.
>
>  drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h             |    1 +
>  drivers/scsi/mpt3sas/mpt3sas_base.c              |  528 ++++++++-
>  drivers/scsi/mpt3sas/mpt3sas_base.h              |    6 +
>  drivers/scsi/mpt3sas/mpt3sas_config.c            |    1 +
>  drivers/scsi/mpt3sas/mpt3sas_scsih.c             |   54 +-
>  16 files changed, 540 insertions(+), 9291 deletions(-)
>
> Thanks,
> Suganath Prabu S
> --
> 2.5.5
>
