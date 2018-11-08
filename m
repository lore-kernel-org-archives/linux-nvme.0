From: Giridhar.Malavali@cavium.com (Malavali, Giridhar)
Date: Thu, 8 Nov 2018 20:32:26 +0000
Subject: [PATCH v4 0/5] qla2xxx: Add FC-NVMe Target support
In-Reply-To: <08c5372d-eba5-ad53-9b10-edc67996dc13@broadcom.com>
References: <20181031164059.6286-1-himanshu.madhani@cavium.com>
 <4896D919-65AC-49F3-90B4-A4D53A9C5C84@cavium.com>
 <08c5372d-eba5-ad53-9b10-edc67996dc13@broadcom.com>
Message-ID: <33C88607-77F1-4898-871A-D192FF4FD0A8@caviumnetworks.com>

Thanks James. Please let us know. 

-- Giri

On 11/8/18, 9:18 AM, "linux-scsi-owner@vger.kernel.org on behalf of James Smart" <linux-scsi-owner@vger.kernel.org on behalf of james.smart@broadcom.com> wrote:

    External Email
    
    Madhani,
    
    I'll be looking through it over the weekend.
    
    -- james
    
    
    On 11/8/2018 8:58 AM, Madhani, Himanshu wrote:
    > Hi James,
    >
    > Any more review comments?
    >
    >> On Oct 31, 2018,@9:40 AM, Himanshu Madhani <Himanshu.Madhani@cavium.com> wrote:
    >>
    >> Hi Martin,
    >>
    >> This series adds support for FC-NVMe Target.
    >>
    >> Patch #1 adds infrastructure to support FC-NVMeT Link Service processing.
    >> Patch #2 adds addes new qla_nvmet.[ch] files for FC-NVMe Target support.
    >> Patch #3 has bulk of changes to add hooks into common code infrastucture and
    >>          adds support for FC-NVMe Target LS4 processing via Purex path.
    >> Patch #4 adds SysFS hook to enable NVMe Target for the port.
    >>
    >> Please apply them to 4.21/scsi-queue at your earliest convenience.
    >>
    >> Changes from v3 -> v4
    >> o Rebased Series on current 4.20/scsi-queue
    >> o Removed NVMET_FCTGTFEAT_{CMD|OPDONE}_IN_ISR as per James Smart's review comment.
    >>
    >> Changes from v2 -> v3
    >> o Reordered patches so that each patch compiles individually and is bisectable.
    >>
    >> Changes from v1 -> v2
    >> o Addressed all comments from Bart.
    >> o Consolidated Patch 1 and Patch 2 into single patch.
    >> o Fixed smatch warning reported by kbuild autommation.
    >> o NVMe Target mode is exclusive at the moment. Cavium driver does not support both
    >>   FCP Target and NVMe Target at the same time. This will be fixed in later updates.
    >>
    >> Thanks,
    >> Himanshu
    >>
    >> Anil Gurumurthy (4):
    >>   qla2xxx_nvmet: Add FC-NVMe Target Link Service request handling
    >>   qla2xxx_nvmet: Add files for FC-NVMe Target support
    >>   qla2xxx_nvmet: Add FC-NVMe Target handling
    >>   qla2xxx_nvmet: Add SysFS node for FC-NVMe Target
    >>
    >> Himanshu Madhani (1):
    >>   qla2xxx: Update driver version to 11.00.00.00-k
    >>
    >> drivers/scsi/qla2xxx/Makefile      |   3 +-
    >> drivers/scsi/qla2xxx/qla_attr.c    |  33 ++
    >> drivers/scsi/qla2xxx/qla_dbg.c     |   1 +
    >> drivers/scsi/qla2xxx/qla_dbg.h     |   2 +
    >> drivers/scsi/qla2xxx/qla_def.h     |  35 +-
    >> drivers/scsi/qla2xxx/qla_fw.h      | 263 ++++++++++
    >> drivers/scsi/qla2xxx/qla_gbl.h     |  24 +-
    >> drivers/scsi/qla2xxx/qla_gs.c      |  16 +-
    >> drivers/scsi/qla2xxx/qla_init.c    |  49 +-
    >> drivers/scsi/qla2xxx/qla_iocb.c    |   8 +-
    >> drivers/scsi/qla2xxx/qla_isr.c     | 112 ++++-
    >> drivers/scsi/qla2xxx/qla_mbx.c     | 101 +++-
    >> drivers/scsi/qla2xxx/qla_nvme.h    |  33 --
    >> drivers/scsi/qla2xxx/qla_nvmet.c   | 831 +++++++++++++++++++++++++++++++
    >> drivers/scsi/qla2xxx/qla_nvmet.h   | 129 +++++
    >> drivers/scsi/qla2xxx/qla_os.c      |  75 ++-
    >> drivers/scsi/qla2xxx/qla_target.c  | 977 ++++++++++++++++++++++++++++++++++++-
    >> drivers/scsi/qla2xxx/qla_target.h  |  90 ++++
    >> drivers/scsi/qla2xxx/qla_version.h |   4 +-
    >> 19 files changed, 2711 insertions(+), 75 deletions(-)
    >> create mode 100644 drivers/scsi/qla2xxx/qla_nvmet.c
    >> create mode 100644 drivers/scsi/qla2xxx/qla_nvmet.h
    >>
    >> --
    >> 2.12.0
    >>
    > Hi Martin,
    >
    > if there are no more review comments. Can we merge this into 4.21/scsi-queue.
    >
    > Thanks,
    > - Himanshu
    >
    
    
