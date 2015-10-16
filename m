From: dan.j.williams@intel.com (Dan Williams)
Date: Thu, 15 Oct 2015 17:06:29 -0700
Subject: [PATCH v2 00/12] blk-integrity lifetime fixes
In-Reply-To: <yq1io67it7u.fsf@sermon.lab.mkp.net>
References: <20151015195939.20721.23101.stgit@dwillia2-desk3.jf.intel.com>
 <yq1io67it7u.fsf@sermon.lab.mkp.net>
Message-ID: <CAPcyv4gcvPTMQCHeXVt_ECnDM_6bvyFCwATX5e1KCe5eg6sdPA@mail.gmail.com>

On Thu, Oct 15, 2015 at 4:53 PM, Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>>>>>> "Dan" == Dan Williams <dan.j.williams at intel.com> writes:
>
> Dan,
>
> Dan> 5/ Fixed up Documentation/ABI/testing/sysfs-block to reflect moving
> Dan> "integrity" sysfs attributes from "disk" to "disk/queue".
>
> You can't change an exported interface. Several apps are depending on
> it.

Hmm, add an "integrity" sysfs link for backwards compatibility, or
leave it as a child of the gendisk kobject?  Probably the latter
because it seems fine if the integrity_kobj has follow the gendisk
lifetime even if the struct blk_integrity info follows the
request_queue.
