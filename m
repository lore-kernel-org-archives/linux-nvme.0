From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sat, 18 May 2019 11:12:03 +0900
Subject: [PATCH V3 0/5] nvme-trace: Add support for fabrics command
In-Reply-To: <20190512073413.32050-1-minwoo.im.dev@gmail.com>
References: <20190512073413.32050-1-minwoo.im.dev@gmail.com>
Message-ID: <20190518021202.GB31204@minwooim-desktop>

On 19-05-12 16:34:08, Minwoo Im wrote:
> Hi,
> 
> Here's a third patchset to support fabrics command tracing.  The first
> patch updated host/trace module to a outside of it to provide common
> interfaces for host and target both.  The second one adds support for
> tracing fabrics command from host-side.  The third is a trivial clean-up
> for providing a helper function to figure out given command structure is
> for fabrics or not.
> 
> The fourth and fifth are the major change points of this patchset.  4th
> patch adds request tracing from the target-side.  5th updated, of course,
> completion of given request.
> 
> Please review.
> Thanks,
> 
> Changes to V2:
>   - Provide a common code for both host and target. (Chaitanya)
>   - Add support for tracing requests in target-side (Chaitanya)
>   - Make it simple in trace.h without branch out from nvme core module
>     (Christoph)
> 
> Changes to V1:
>   - fabrics commands should also be decoded, not just showing that it's
>     a fabrics command. (Christoph)
>   - do not make it within nvme admin commands (Chaitanya)
> 
> Minwoo Im (5):
>   nvme: Make trace common for host and target both
>   nvme-trace: Support tracing fabrics commands from host-side
>   nvme: Introduce nvme_is_fabrics to check fabrics cmd
>   nvme-trace: Add tracing for req_init in trarget
>   nvme-trace: Add tracing for req_comp in target

Ping :)
