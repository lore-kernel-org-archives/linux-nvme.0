From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Sat, 05 Nov 2016 11:30:32 -0700
Subject: [PATCH v4 7/7] nvme-fabrics: Add FC LLDD loopback driver to
 test FC-NVME
In-Reply-To: <581cf3c7.3rjLOSaBkyS0fzzq%james.smart@broadcom.com>
References: <581cf3c7.3rjLOSaBkyS0fzzq%james.smart@broadcom.com>
Message-ID: <1478370632.17308.8.camel@linux.intel.com>

On Fri, 2016-11-04@13:47 -0700, James Smart wrote:
> Add FC LLDD loopback driver to test FC host and target transport
> within
> nvme-fabrics
> 
> To aid in the development and testing of the lower-level api of the
> FC
> transport, this loopback driver has been created to act as if it were
> a
> FC hba driver supporting both the host interfaces as well as the
> target
> interfaces with the nvme FC transport.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> 
> ---
> v4 mods:
> - corrected newnport memory leak
> - Checkpatch updates - S_IWUSR to 0200

Looks good,
Reviewed-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
