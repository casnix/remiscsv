# Tell() -- Counts how many tabs to write.
# Tabs are two spaces in width.
#-- Arguments: None.
#-- Returns: A string filled with two-space tabs, proportional to `tabs`.
sub Tell {
  my $tabsToFill;
  for(my $n = 0; $n < ${ (tabs) }; $n++){
    $tabsToFill .= "  ";
  }

  return $tabsToFill;
}
