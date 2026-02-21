    dark_theme <- bs_theme(
      version = 5,
      "bslib_spacer" = "0rem",
      # Core palette
      bg       = "#0F1115",  # near-black 
      fg       = "#E6E6E6",  # soft light grey for text
      primary  = "#C2504E",  # vivid red accent
      secondary= "#828995",  # cool grey for subtle accents
      # Surfaces & borders
      "body-bg"             = "#0F1115",
      "body-color"          = "#E6E6E6",
      "card-bg"             = "#0F1115",
      "card-border-color"   = "#2A2F3A",
      "border-color"        = "#2A2F3A",
      # Links & states
      "link-color"          = "#C2504E",   # lighter red for links
      "link-hover-color"    = "#FF817C",
      "success"             = "#28A745",
      "warning"             = "#E0A800",
      "danger"              = "#C2504E",
      # Inputs
      "input-bg"            = "#12151B",
      "input-border-color"  = "#343A46",
      "input-color"         = "#E6E6E6",
      "input-placeholder-color" = "#9AA1AE",
      # Navbar
      "navbar-dark-color"        = "#E6E6E6",
      "navbar-dark-hover-color"  = "#FFFFFF",
      "navbar-dark-active-color" = "#FFFFFF",
      "navbar-dark-brand-color"  = "#FFFFFF",
      "navbar-dark-brand-hover-color" = "#FFFFFF"
    ) |>
      # Extra polish with CSS rules
      bs_add_rules("
        :root {
          --panel-bg: #0F1115;
          --panel-elev: #171A21;
          --muted: #A6ADBB;
          --accent: #E53935;
          --accent-2: #FF6B66;
        }
        
        


        /* Buttons */
        .btn-primary {
          background-color: var(--accent);
          border-color: var(--accent);
        }
        .btn-primary:hover, .btn-primary:focus {
          background-color: #C62828;
          border-color: #C62828;
          box-shadow: 0 0 0 .2rem rgba(229,57,53,.25);
        }
        .btn-outline-primary {
          color: var(--accent);
          border-color: var(--accent);
        }
        .btn-outline-primary:hover {
          background-color: var(--accent);
          color: #fff;
        }
        /* Inputs */
        .form-control, .form-select {
          background-color: #12151B;
          color: #E6E6E6;
          border-color: #343A46;
        }
        .form-control:focus, .form-select:focus {
          color: #FFFFFF;
          background-color: #151922;
          border-color: var(--accent);
          box-shadow: 0 0 0 .2rem rgba(229,57,53,.2);
        }
        /* Tables */
        .table {
          color: #D7D9DE;
        }
        .table thead th {
          border-bottom-color: #2A2F3A;
          color: #F0F0F0;
        }
        .table-striped > tbody > tr:nth-of-type(odd) {
          --bs-table-accent-bg: #151922;
          color: inherit;
        }
        /* Navs / Pills */
        .nav-link, .nav-pills .nav-link {
          color: #C7CCD6;
        }
        .nav-pills .nav-link.active {
          background-color: var(--accent);
        }
        /* Code blocks (if any) */
        pre, code {
          background: #11131A;
          color: #F0F0F0;
        }
        
        /* Ensure DT widgets grow vertically and don't clip */
  .datatables.html-widget,
  .datatables.html-widget .dataTables_wrapper {
    height: auto !important;
    overflow: visible !important;
  }
  
  /* When scrollX=TRUE, DataTables creates .dataTables_scrollBody with a computed height.
     Force it to expand with content and drop vertical scrolling. */
  .dataTables_wrapper .dataTables_scrollBody {
    height: auto !important;
    max-height: none !important;
    overflow-y: visible !important;
  }
  
  /* Make sure card bodies never clip vertically (some themes/cards can set overflow:auto) */
  .card .card-body,
  .bslib-card .card-body {
    overflow: visible !important;
  }
  
  /* Base font size + line height */
      #tb_table table.dataTable,
      #tb_table .dataTables_scrollHead table.dataTable,
      #tb_table .dataTables_scrollBody table.dataTable {
        font-size: 0.875rem;   /* ~14px; tweak as you like */
        line-height: 1.15;
      }
  
      /* Body cells: tighter vertical + horizontal padding */
      #tb_table table.dataTable tbody td,
      #tb_table .dataTables_scrollBody table.dataTable tbody td {
        padding-top: 4px !important;
        padding-bottom: 4px !important;
        padding-left: 6px !important;
        padding-right: 6px !important;
        white-space: nowrap;  /* keep rows short; remove if you want wrapping */
      }
  
      /* Header cells: reduce padding and avoid wrap */
      #tb_table table.dataTable thead th,
      #tb_table .dataTables_scrollHead table.dataTable thead th {
        padding-top: 6px !important;
        padding-bottom: 6px !important;
        padding-left: 6px !important;
        padding-right: 6px !important;
        font-size: 0.9rem;  /* optional: a touch larger than body */
        line-height: 1.1;
        white-space: nowrap;
      }
  
  
  /* Base font size + line height */
      #sv_table table.dataTable,
      #sv_table .dataTables_scrollHead table.dataTable,
      #sv_table .dataTables_scrollBody table.dataTable {
        font-size: 0.875rem;   /* ~14px; tweak as you like */
        line-height: 1.15;
      }
  
      /* Body cells: tighter vertical + horizontal padding */
      #sv_table table.dataTable tbody td,
      #sv_table .dataTables_scrollBody table.dataTable tbody td {
        padding-top: 4px !important;
        padding-bottom: 4px !important;
        padding-left: 6px !important;
        padding-right: 6px !important;
        white-space: nowrap;  /* keep rows short; remove if you want wrapping */
      }
  
      /* Header cells: reduce padding and avoid wrap */
      #sv_table table.dataTable thead th,
      #sv_table .dataTables_scrollHead table.dataTable thead th {
        padding-top: 6px !important;
        padding-bottom: 6px !important;
        padding-left: 6px !important;
        padding-right: 6px !important;
        font-size: 0.9rem;  /* optional: a touch larger than body */
        line-height: 1.1;
        white-space: nowrap;
      }
  
  /* Base font size + line height */
      #master_table table.dataTable,
      #master_table .dataTables_scrollHead table.dataTable,
      #master_table .dataTables_scrollBody table.dataTable {
        font-size: 0.875rem;   /* ~14px; tweak as you like */
        line-height: 1.15;
      }
  
      /* Body cells: tighter vertical + horizontal padding */
      #master_table table.dataTable tbody td,
      #master_table .dataTables_scrollBody table.dataTable tbody td {
        padding-top: 4px !important;
        padding-bottom: 4px !important;
        padding-left: 6px !important;
        padding-right: 6px !important;
        white-space: nowrap;  /* keep rows short; remove if you want wrapping */
      }
  
      /* Header cells: reduce padding and avoid wrap */
      #master_table table.dataTable thead th,
      #master_table .dataTables_scrollHead table.dataTable thead th {
        padding-top: 6px !important;
        padding-bottom: 6px !important;
        padding-left: 6px !important;
        padding-right: 6px !important;
        font-size: 0.9rem;  /* optional: a touch larger than body */
        line-height: 1.1;
        white-space: nowrap;
      }
  
    
  /* Base font size + line height */
      #size_table table.dataTable,
      #size_table .dataTables_scrollHead table.dataTable,
      #size_table .dataTables_scrollBody table.dataTable {
        font-size: 0.875rem;   /* ~14px; tweak as you like */
        line-height: 1.15;
      }
  
      /* Body cells: tighter vertical + horizontal padding */
      #size_table table.dataTable tbody td,
      #size_table .dataTables_scrollBody table.dataTable tbody td {
        padding-top: 4px !important;
        padding-bottom: 4px !important;
        padding-left: 6px !important;
        padding-right: 6px !important;
        white-space: nowrap;  /* keep rows short; remove if you want wrapping */
      }
  
      /* Header cells: reduce padding and avoid wrap */
      #size_table table.dataTable thead th,
      #size_table .dataTables_scrollHead table.dataTable thead th {
        padding-top: 6px !important;
        padding-bottom: 6px !important;
        padding-left: 6px !important;
        padding-right: 6px !important;
        font-size: 0.9rem;  /* optional: a touch larger than body */
        line-height: 1.1;
        white-space: nowrap;
      }
  
  
  
  /* BS5/bslib: underline the active nav link */
  .navbar .navbar-nav .nav-link {
    border-bottom: 3px solid transparent;
    padding-bottom: .5rem; /* tweak to taste */
  }
  
  .navbar .navbar-nav .nav-link.active,
  .navbar .navbar-nav .nav-link.show,
  .navbar .navbar-nav .nav-link:has(+ .dropdown-menu.show) {
    border-bottom: 3px solid #C2504E !important;
  }
  
  
  /* Red underline for the active navbar tab */
  .navbar .navbar-nav > .active > a,
  .navbar .navbar-nav > .active > a:focus,
  .navbar .navbar-nav > .active > a:hover {
    border-bottom: 3px solid #C2504E !important; /* thickness + color of underline */
    padding-bottom: 12px; /* adjust so the underline sits nicely */
  }
  
  
  
  /* Hover state */
  .navbar-nav > li > a:hover {
    color: #C2504E !important;
  }
  
  
  /* Bold last two visible rows for only the master_table DataTable */
  #master_table table.dataTable tbody tr:nth-last-child(-n + 2) {
    font-weight: 700 !important;
  }
  
  
  /* =========================================================
     Reactable: totals_dt — exact match to master_table, no outlines
     ========================================================= */
  
  /* Font size + line height (keep consistent) */
  #totals_dt.reactable,
  #totals_dt .rt-table,
  #totals_dt .rt-thead,
  #totals_dt .rt-tbody,
  #totals_dt .rt-tr,
  #totals_dt .rt-td,
  #totals_dt .rt-th {
    font-size: 0.875rem !important;
    line-height: 0.95 !important;
    color: #E6E6E6;
  }
  
  /* Header: keep the dark header color; remove outlines if desired */
  #totals_dt .rt-thead .rt-tr .rt-th,
  #totals_dt .rt-thead .rt-tr .rt-td {
    padding: 0px !important;
    font-size: 0.9rem !important;
    line-height: 1.1 !important;
    white-space: nowrap;
    color: #E6E6E6;
    background-color: #0F1115;
    border: none !important;                 /* <-- remove header border line */
    box-shadow: none !important;
  }
  
  /* Body cells: compact padding; remove borders/outlines entirely */
  #totals_dt .rt-tbody .rt-tr .rt-td {
    padding: 0px 0px !important;
    white-space: nowrap;
    background-color: #0F1115;               /* base row bg */
    border: none !important;                  /* <-- remove cell borders */
    box-shadow: none !important;
  }
  
  /* Zebra striping (even rows) */
  #totals_dt .rt-tbody .rt-tr-group:nth-of-type(even) .rt-td {
    background-color: #1C1316 ;
  }
  
  /* Hover highlight: must come AFTER base/striping and use !important */
  #totals_dt .rt-tbody .rt-tr:hover .rt-td {
    background-color: #251518 ;    /* subtle lift */
  }
  
  /* Remove outer outline/box-shadow on the widget container */
  #totals_dt.reactable {
    border: none !important;
    box-shadow: none !important;
  }
  
  /* =========================================================
     Details reactable inside totals_dt
     - You currently set outlined = TRUE; to keep no outlines, override it.
     - We also apply the same striping/hover/colors.
     ========================================================= */
  
  /* Remove outer border/box-shadow from nested/details reactables */
  #totals_dt .reactable {
    border: none !important;
    box-shadow: none !important;
  }
  
  /* Make nested table colors consistent with parent */
  #totals_dt .reactable .rt-thead .rt-tr .rt-th,
  #totals_dt .reactable .rt-thead .rt-tr .rt-td {
    background-color: #0F1115 !important;
    color: #E6E6E6 !important;
    border: none !important;
  }
  
  #totals_dt .reactable .rt-tbody .rt-tr .rt-td {
    background-color: #0F1115 !important;
    color: #0F1115 !important;
    border: none !important;
    padding: 0px 0px !important;
    white-space: nowrap;
  }
  
  /* Striping + hover for nested/details table */
  #totals_dt .reactable .rt-tbody .rt-tr-group:nth-of-type(odd) .rt-td {
    background-color: #0F1115 !important;
  }
  #totals_dt .reactable .rt-tbody .rt-tr:hover .rt-td {
    background-color: #0F1115 !important;
  }
  


/* Base (collapsed) state — update the side you actually use for the triangle */
#totals_dt .rt-expander::after {
  /* examples—keep your existing border widths/orientation */
  /* border-width: 5px 4px 0 4px;           /\ down arrow */
  /* border-style: solid; */
  /* border-color: #E6E6E6 transparent transparent transparent; */
  
  /* If you prefer to only override colour: */
  border-top-color: #E6E6E6 !important;  /* ▼ style */
  border-right-color: #E6E6E6;           /* ► style (if used) */
  border-left-color: #E6E6E6;            /* ◄ style (if used) */
  filter: none !important;
  opacity: 1;
}

/* Expanded state—pointing a different direction? Override that side too */
#totals_dt .rt-tr.-expanded .rt-expander::after {
  border-top-color: #E6E6E6 !important;   /* ▼ */
  border-right-color: #E6E6E6 !important; /* ► */
  border-left-color: #E6E6E6 !important;  /* ◄ */
}



/* No vertical gutter within rows (usually 0 already unless you used gy-*) */
  .row { --bs-gutter-y: 0; }

  /* Reduce bottom margin on cards/value boxes so rows collapse closer */
  .card, .bslib-value-box { margin-bottom: 0rem; } /* try .125rem or 0 if needed */


    .value-box-value {
      font-size: 1.5rem !important;    /* adjust as needed */
      line-height: 1.0;
    }

  
  
    /* App title (navbar brand) */
    .navbar .navbar-brand {
      color: #C2504E !important;
    }



.rt-tr[style*='background-color: rgb(255, 0, 0)'] .rt-td {
    background-color: #C2504E !important;
    color: #0F1115 !important;
  }


/* Keep expanded row bright red even when hovered */
    .reactable .rt-tr.is-expanded,
    .reactable .rt-tr.is-expanded:hover,
    .reactable .rt-tr.is-expanded:hover .rt-td,
    .reactable .rt-tr.is-expanded .rt-td {
      background-color: #C2504E !important;
      color: #0F1115 !important;
    }

strong {
      display: inline !important;
    }


      ")
  
    