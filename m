From: keith.busch@intel.com (Keith Busch)
Date: Fri, 24 Feb 2017 12:42:00 -0500
Subject: nvme-cli: JSON format Memory leak fixes.
In-Reply-To: <1487903977-11963-1-git-send-email-chaitanya.kulkarni@hgst.com>
References: <1487903977-11963-1-git-send-email-chaitanya.kulkarni@hgst.com>
Message-ID: <20170224174200.GB15307@localhost.localdomain>

On Thu, Feb 23, 2017@06:39:30PM -0800, Chaitanya Kulkarni wrote:
> 
> Hi,
> 
> Following patch series provides multiple memory leak fixes
> for nvme-cli commands. Memory leaks were found especially
> when using JSON format for following list of commands:-
>  1. id-ctrl.
>  2. id-ns.
>  3. error-log.
>  4. resv-report.
>  5. smart-log.
>  6. fw-log.
>  7. json_add_smart_log().

Thanks, all applied.
