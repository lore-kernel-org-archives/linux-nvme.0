From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Fri, 03 Aug 2018 19:18:06 +0900
Subject: [PATCH V3 1/2] nvme-cli: add minimal ana-log page support
In-Reply-To: <20180802032819.6558-2-chaitanya.kulkarni@wdc.com>
References: <20180802032819.6558-1-chaitanya.kulkarni@wdc.com>
 <20180802032819.6558-2-chaitanya.kulkarni@wdc.com>
Message-ID: <1533291486.2982.10.camel@gmail.com>

Hi Chaitanya,

On Wed, 2018-08-01@20:28 -0700, Chaitanya Kulkarni wrote:
> @@ -1550,7 +1647,7 @@ char *nvme_status_to_string(__u32 status)
> ?	case NVME_SC_SANITIZE_IN_PROGRESS:	return "SANITIZE_IN_PROGRESS: The requested function is prohibited while a sanitize operation is in progress";
> ?	case NVME_SC_LBA_RANGE:			return "LBA_RANGE: The command references a LBA that exceeds the size of the namespace";
> ?	case NVME_SC_CAP_EXCEEDED:		return "CAP_EXCEEDED: The execution of the command has caused the capacity of the namespace to be exceeded";
> -	case NVME_SC_NS_NOT_READY:		return "NS_NOT_READY: The namespace is not ready to be accessed";
> +	case NVME_SC_NS_NOT_READY:		return "NS_NOT_READY: The namespace is not ready to be accessed as a result of a condition other than a condition that is
> reported as an Asymmetric Namespace Access condition";
> ?	case NVME_SC_RESERVATION_CONFLICT:	return "RESERVATION_CONFLICT: The command was aborted due to a conflict with a reservation held on the accessed namespace";
> ?	case NVME_SC_CQ_INVALID:		return "CQ_INVALID: The Completion Queue identifier specified in the command does not exist";
> ?	case NVME_SC_QID_INVALID:		return "QID_INVALID: The creation of the I/O Completion Queue failed due to an invalid queue identifier specified as part of the
> command. An invalid queue identifier is one that is currently in use or one that is outside the range supported by the controller";
> @@ -1590,6 +1687,9 @@ char *nvme_status_to_string(__u32 status)
> ?	case NVME_SC_COMPARE_FAILED:		return "COMPARE_FAILED: The command failed due to a miscompare during a Compare command";
> ?	case NVME_SC_ACCESS_DENIED:		return "ACCESS_DENIED: Access to the namespace and/or LBA range is denied due to lack of access rights";
> ?	case NVME_SC_UNWRITTEN_BLOCK:		return "UNWRITTEN_BLOCK: The command failed due to an attempt to read from an LBA range containing a deallocated or
> unwritten logical block";
> +	case NVME_SC_ANA_PERSISTENT_LOSS:	return "Asymmetric Namespace Access Persistent Loss";
> +	case NVME_SC_ANA_INACCESSIBLE:		return "Asymmetric Namespace Access Inaccessible";
> +	case NVME_SC_ANA_TRANSITION:		return "Asymmetric Namespace Access Transition";
> ?	default:				return "Unknown";
> ?	}
> ?}

If possible, can we change the descriptions to something like TP 4004 just
like the others or shorten descriptions? ?All the other state strings are
having statements from the doc.

Thanks,
????????Minwoo Im
