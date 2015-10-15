From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Thu, 15 Oct 2015 19:53:57 -0400
Subject: [PATCH v2 00/12] blk-integrity lifetime fixes
In-Reply-To: <20151015195939.20721.23101.stgit@dwillia2-desk3.jf.intel.com>
 (Dan Williams's message of "Thu, 15 Oct 2015 15:59:39 -0400")
References: <20151015195939.20721.23101.stgit@dwillia2-desk3.jf.intel.com>
Message-ID: <yq1io67it7u.fsf@sermon.lab.mkp.net>

>>>>> "Dan" == Dan Williams <dan.j.williams at intel.com> writes:

Dan,

Dan> 5/ Fixed up Documentation/ABI/testing/sysfs-block to reflect moving
Dan> "integrity" sysfs attributes from "disk" to "disk/queue".

You can't change an exported interface. Several apps are depending on
it.

-- 
Martin K. Petersen	Oracle Linux Engineering
