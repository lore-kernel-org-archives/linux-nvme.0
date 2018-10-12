From: keith.busch@linux.intel.com (Keith Busch)
Date: Fri, 12 Oct 2018 13:05:33 -0600
Subject: [PATCH 2/2] nvme-cli:  Add help text for wdc-plugin command
 vs-internal-log. Update help text for wdc-plugin command cap-diag.
In-Reply-To: <1539359420-1447-1-git-send-email-jeff.lien@wdc.com>
References: <1539359420-1447-1-git-send-email-jeff.lien@wdc.com>
Message-ID: <20181012190533.GB15812@localhost.localdomain>

On Fri, Oct 12, 2018@03:50:35PM +0000, Jeffrey Lien wrote:
> Signed-off-by: Jeff Lien <jeff.lien at wdc.com>
> ---
>  Documentation/nvme-wdc-cap-diag.1           |  57 +-
>  Documentation/nvme-wdc-cap-diag.html        |  43 +-
>  Documentation/nvme-wdc-cap-diag.txt         |  16 +-
>  Documentation/nvme-wdc-vs-internal-log.1    | 163 ++++++
>  Documentation/nvme-wdc-vs-internal-log.html | 859 ++++++++++++++++++++++++++++
>  Documentation/nvme-wdc-vs-internal-log.txt  |  64 +++
>  6 files changed, 1191 insertions(+), 11 deletions(-)
>  create mode 100644 Documentation/nvme-wdc-vs-internal-log.1
>  create mode 100644 Documentation/nvme-wdc-vs-internal-log.html
>  create mode 100644 Documentation/nvme-wdc-vs-internal-log.txt

Thanks, Jeff. I've applied these, but I yanked out the .html and .1 files
and regenerated those on my side. Those auto-generated files generally
have a difficult time merging, so I'd rather to just apply the .txt
files and update docs periodically or as needed.
